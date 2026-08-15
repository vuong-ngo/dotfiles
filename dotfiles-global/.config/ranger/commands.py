# -*- coding: utf-8 -*-
# ============================================================
# RANGER CUSTOM COMMANDS (PLUGIN-FREE NATIVE EXTENSIONS)
# Features: Compression, Extraction, Exporting, Clipboard Integration,
# Fuzzy Search (fzf), Content Search (ripgrep), directory creation, chmod.
# ============================================================

import os
import shlex
import subprocess
from ranger.api.commands import Command

class compress(Command):
    """
    :compress <archive_name>

    Compresses selected files and directories into an archive.
    Supported extensions: .zip, .tar.gz, .tgz, .tar.bz2, .tbz2, .tar.xz, .txz, .tar, .7z, .gz
    """
    def execute(self):
        cwd = self.fm.thisdir.path
        marked_files = [f.relative_path for f in self.fm.thistab.get_selection()]

        if not marked_files:
            self.fm.notify("No files selected for compression!", bad=True)
            return

        if not self.arg(1):
            default_name = os.path.basename(marked_files[0]) if len(marked_files) == 1 else "archive"
            self.fm.open_console(f"compress {default_name}.zip")
            return

        archive_name = self.arg(1)
        output_path = os.path.expanduser(archive_name)
        if not os.path.isabs(output_path):
            output_path = os.path.join(cwd, output_path)

        ext = archive_name.lower()

        if ext.endswith('.zip'):
            cmd = ['zip', '-r', output_path] + marked_files
        elif ext.endswith('.tar.gz') or ext.endswith('.tgz'):
            cmd = ['tar', '-czvf', output_path] + marked_files
        elif ext.endswith('.tar.bz2') or ext.endswith('.tbz2'):
            cmd = ['tar', '-cjvf', output_path] + marked_files
        elif ext.endswith('.tar.xz') or ext.endswith('.txz'):
            cmd = ['tar', '-cJvf', output_path] + marked_files
        elif ext.endswith('.tar'):
            cmd = ['tar', '-cvf', output_path] + marked_files
        elif ext.endswith('.7z'):
            cmd = ['7z', 'a', output_path] + marked_files
        elif ext.endswith('.gz') and len(marked_files) == 1 and not os.path.isdir(marked_files[0]):
            cmd = ['gzip', '-k', marked_files[0]]
        else:
            cmd = ['atool', '-a', output_path] + marked_files

        try:
            self.fm.notify(f"Compressing {len(marked_files)} item(s) to '{os.path.basename(output_path)}'...")
            proc = subprocess.Popen(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = proc.communicate()
            if proc.returncode == 0:
                self.fm.notify(f"Compression complete: {os.path.basename(output_path)}")
                self.fm.reload_cwd()
            else:
                err_msg = stderr.decode('utf-8', errors='ignore').strip() or "Unknown error"
                self.fm.notify(f"Compression failed: {err_msg}", bad=True)
        except Exception as e:
            self.fm.notify(f"Error during compression: {e}", bad=True)

    def tab(self, tabnum):
        marked_files = [f.relative_path for f in self.fm.thistab.get_selection()]
        if marked_files:
            base = os.path.basename(marked_files[0].rstrip('/'))
            return [
                f"compress {base}.zip",
                f"compress {base}.tar.gz",
                f"compress {base}.tar.xz",
                f"compress {base}.7z",
            ]
        return ["compress archive.zip", "compress archive.tar.gz"]


class extract(Command):
    """
    :extract [destination_directory]

    Extracts selected archive file(s) into current directory or target folder.
    """
    def execute(self):
        cwd = self.fm.thisdir.path
        marked_files = [f.path for f in self.fm.thistab.get_selection()]

        if not marked_files:
            self.fm.notify("No archive selected!", bad=True)
            return

        dest_dir = self.rest(1).strip()
        if dest_dir:
            dest_dir = os.path.expanduser(dest_dir)
            if not os.path.isabs(dest_dir):
                dest_dir = os.path.join(cwd, dest_dir)
            os.makedirs(dest_dir, exist_ok=True)
        else:
            dest_dir = cwd

        for filepath in marked_files:
            fname = os.path.basename(filepath)
            ext = fname.lower()
            self.fm.notify(f"Extracting '{fname}'...")

            if ext.endswith('.zip'):
                cmd = ['unzip', '-o', filepath, '-d', dest_dir]
            elif ext.endswith('.tar.gz') or ext.endswith('.tgz'):
                cmd = ['tar', '-xzvf', filepath, '-C', dest_dir]
            elif ext.endswith('.tar.bz2') or ext.endswith('.tbz2'):
                cmd = ['tar', '-xjvf', filepath, '-C', dest_dir]
            elif ext.endswith('.tar.xz') or ext.endswith('.txz'):
                cmd = ['tar', '-xJvf', filepath, '-C', dest_dir]
            elif ext.endswith('.tar'):
                cmd = ['tar', '-xvf', filepath, '-C', dest_dir]
            elif ext.endswith('.7z') or ext.endswith('.rar'):
                cmd = ['7z', 'x', f'-o{dest_dir}', '-y', filepath]
            elif ext.endswith('.gz') and not ext.endswith('.tar.gz'):
                cmd = ['gunzip', '-k', filepath]
            else:
                cmd = ['atool', '-x', f'--directory={dest_dir}', filepath]

            try:
                proc = subprocess.Popen(cmd, cwd=cwd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
                stdout, stderr = proc.communicate()
                if proc.returncode == 0:
                    self.fm.notify(f"Successfully extracted: {fname}")
                else:
                    err_msg = stderr.decode('utf-8', errors='ignore').strip() or "Extraction failed"
                    self.fm.notify(f"Extraction error for '{fname}': {err_msg}", bad=True)
            except Exception as e:
                self.fm.notify(f"Failed to extract '{fname}': {e}", bad=True)

        self.fm.reload_cwd()

    def tab(self, tabnum):
        return self._tab_directory_content()


class export(Command):
    """
    :export <destination_directory>

    Exports (copies) selected items to target directory.
    """
    def execute(self):
        cwd = self.fm.thisdir.path
        marked_files = [f.path for f in self.fm.thistab.get_selection()]

        if not marked_files:
            self.fm.notify("No items selected for export!", bad=True)
            return

        dest_dir = self.rest(1).strip()
        if not dest_dir:
            self.fm.open_console("export ")
            return

        dest_dir = os.path.expanduser(dest_dir)
        if not os.path.isabs(dest_dir):
            dest_dir = os.path.join(cwd, dest_dir)

        try:
            os.makedirs(dest_dir, exist_ok=True)
            cmd = ['cp', '-r', '-v'] + marked_files + [dest_dir]
            proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            stdout, stderr = proc.communicate()
            if proc.returncode == 0:
                self.fm.notify(f"Exported {len(marked_files)} item(s) to '{dest_dir}'")
            else:
                err = stderr.decode('utf-8', errors='ignore').strip()
                self.fm.notify(f"Export failed: {err}", bad=True)
        except Exception as e:
            self.fm.notify(f"Export error: {e}", bad=True)

    def tab(self, tabnum):
        return self._tab_directory_content()


class export_to_clipboard(Command):
    """
    :export_to_clipboard [paths|names]

    Copies selected file paths or names to system clipboard (wl-copy or xclip).
    """
    def execute(self):
        marked_files = self.fm.thistab.get_selection()
        if not marked_files:
            self.fm.notify("No items selected!", bad=True)
            return

        mode = self.arg(1).lower() if self.arg(1) else "paths"
        if mode == "names":
            content = "\n".join([f.basename for f in marked_files])
        else:
            content = "\n".join([f.path for f in marked_files])

        copied = False
        for clip_cmd in [['wl-copy'], ['xclip', '-selection', 'clipboard']]:
            try:
                proc = subprocess.Popen(clip_cmd, stdin=subprocess.PIPE, stderr=subprocess.PIPE)
                proc.communicate(input=content.encode('utf-8'))
                if proc.returncode == 0:
                    copied = True
                    break
            except FileNotFoundError:
                continue

        if copied:
            self.fm.notify(f"Copied {len(marked_files)} {mode} to clipboard!")
        else:
            self.fm.notify("Clipboard tool (wl-copy or xclip) not found!", bad=True)


class fzf_select(Command):
    """
    :fzf_select

    Find a file or directory using fzf and jump to it in Ranger.
    """
    def execute(self):
        cmd = "fd --hidden --follow --exclude .git 2>/dev/null || find . -maxdepth 4 -not -path '*/.*'"
        fzf = self.fm.execute_command(f"{cmd} | fzf --no-multi --height=50% --reverse", stdout=subprocess.PIPE)
        stdout, _ = fzf.communicate()
        if fzf.returncode == 0:
            selected_path = stdout.decode('utf-8', errors='ignore').strip()
            if selected_path:
                if os.path.isdir(selected_path):
                    self.fm.cd(selected_path)
                else:
                    self.fm.select_file(selected_path)


class fzf_ripgrep(Command):
    """
    :fzf_ripgrep

    Search content inside files using ripgrep + fzf and jump to the matching file.
    """
    def execute(self):
        cmd = "rg --line-number --no-heading --smart-case . 2>/dev/null | fzf --height=50% --reverse"
        proc = self.fm.execute_command(cmd, stdout=subprocess.PIPE)
        stdout, _ = proc.communicate()
        if proc.returncode == 0:
            line = stdout.decode('utf-8', errors='ignore').strip()
            if line:
                file_path = line.split(':')[0]
                self.fm.select_file(file_path)


class mkcd(Command):
    """
    :mkcd <directory_name>

    Creates a directory and immediately changes into it.
    """
    def execute(self):
        if not self.arg(1):
            self.fm.open_console("mkcd ")
            return
        dest = os.path.expanduser(self.rest(1).strip())
        try:
            os.makedirs(dest, exist_ok=True)
            self.fm.cd(dest)
        except Exception as e:
            self.fm.notify(f"Failed to create directory: {e}", bad=True)


class chmod(Command):
    """
    :chmod <mode>

    Changes permissions for selected files.
    """
    def execute(self):
        mode = self.arg(1)
        if not mode:
            self.fm.open_console("chmod ")
            return
        marked_files = [f.path for f in self.fm.thistab.get_selection()]
        for filepath in marked_files:
            try:
                subprocess.run(['chmod', mode, filepath], check=True)
            except Exception as e:
                self.fm.notify(f"Error executing chmod {mode} on '{filepath}': {e}", bad=True)
        self.fm.reload_cwd()
