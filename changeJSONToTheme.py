import tkinter as tk
from tkinter import scrolledtext, filedialog, messagebox
import json
import os
import re
try:
    import pyperclip
except Exception:
    pyperclip = None


def hex_to_kotlin(hex_str: str) -> str:
    s = hex_str.strip().lstrip('#')
    # Support RRGGBB or AARRGGBB
    if len(s) == 6:
        return '0xFF' + s.upper()
    if len(s) == 8:
        # assume AARRGGBB -> Kotlin Color expects 0xAARRGGBB
        return '0x' + s.upper()
    # fallback: try to extract hex pairs
    m = re.search(r'([0-9a-fA-F]{6,8})', hex_str)
    if m:
        return '0x' + m.group(1).upper()
    return '0xFFFFFFFF'


def sanitize_name(name: str, isTheme : bool) -> str:
    # make a valid Kotlin identifier: replace non-alnum with underscore, avoid leading digits
    s = re.sub(r'[^0-9a-zA-Z_]', '_', name)
    if re.match(r'^[0-9]', s):
        s = '_' + s
    if isTheme:
        s = s.replace('light', '').replace('dark', '')
        return s[0].lower() + s[1:]
    else:
        return s


def json_to_kotlin_colors(data: dict, isTheme : bool, package: str = None, file_name: str = 'Colors.kt') -> str:
    lines = []
    if package:
        lines.append(f'package {package}')
        lines.append('')
    if not isTheme:
        lines.append('import androidx.compose.ui.graphics.Color')
    lines.append('')

    if not isTheme:
        formater = lambda var_name, kotlin_hex: f'val {var_name} = Color({kotlin_hex})'
    else :
        formater = lambda var_name, kotlin_hex: f'{var_name} = Color({kotlin_hex}),'
    for key, value in data.items():
        var_name = sanitize_name(key, isTheme)
        kotlin_hex = hex_to_kotlin(str(value))
        lines.append(formater(var_name, kotlin_hex))

    lines.append('')
    lines.append('// You can use these color vals in your Theme.kt or Colors.kt files.')
    return '\n'.join(lines)


def load_json_file():
    path = filedialog.askopenfilename(filetypes=[('JSON files', '*.json'), ('All files', '*.*')])
    if not path:
        return
    try:
        with open(path, 'r', encoding='utf-8') as f:
            txt = f.read()
        input_text.delete('1.0', tk.END)
        input_text.insert(tk.END, txt)
        entry_json_path.delete(0, tk.END)
        entry_json_path.insert(0, path)
    except Exception as e:
        messagebox.showerror('Error', f'Failed to open file:\n{e}')


def save_kotlin_file():
    kotlin_code = generate_kotlin()
    if kotlin_code is None:
        return
    path = filedialog.asksaveasfilename(defaultextension='.kt', filetypes=[('Kotlin files', '*.kt'), ('All files', '*.*')])
    if not path:
        return
    try:
        with open(path, 'w', encoding='utf-8') as f:
            f.write(kotlin_code)
        messagebox.showinfo('Saved', f'Saved to {path}')
    except Exception as e:
        messagebox.showerror('Error', f'Failed to save file:\n{e}')


def copy_to_clipboard():
    kotlin_code = generate_kotlin()
    if kotlin_code is None:
        return
    if pyperclip:
        pyperclip.copy(kotlin_code)
        messagebox.showinfo('Copied', 'Kotlin code copied to clipboard')
    else:
        messagebox.showwarning('pyperclip missing', 'pyperclip not installed; cannot copy to clipboard')


def clear_all():
    input_text.delete('1.0', tk.END)
    output_text.delete('1.0', tk.END)
    entry_json_path.delete(0, tk.END)
    entry_package.delete(0, tk.END)


def generate_kotlin(isTheme : bool) -> str:
    txt = input_text.get('1.0', tk.END).strip()
    if not txt:
        messagebox.showwarning('No input', 'Please paste or load a JSON file first')
        return None
    try:
        data = json.loads(txt)
        if not isinstance(data, dict):
            messagebox.showwarning('Invalid JSON', 'Top-level JSON value should be an object/dictionary of name->color')
            return None
    except Exception as e:
        messagebox.showerror('JSON Error', f'Failed to parse JSON:\n{e}')
        return None

    package = entry_package.get().strip() or None
    kotlin = json_to_kotlin_colors(data, isTheme, package)
    output_text.delete('1.0', tk.END)
    output_text.insert(tk.END, kotlin)
    return kotlin


# Build Tkinter interface
root = tk.Tk()
root.title('JSON → Theme.kt Converter')

frm_top = tk.Frame(root)
frm_top.pack(padx=8, pady=6, fill='x')

tk.Label(frm_top, text='JSON file:').grid(row=0, column=0, sticky='w')
entry_json_path = tk.Entry(frm_top, width=50)
entry_json_path.grid(row=0, column=1, padx=4)
tk.Button(frm_top, text='Open', command=load_json_file).grid(row=0, column=2, padx=4)

tk.Label(frm_top, text='Package (optional):').grid(row=1, column=0, sticky='w')
entry_package = tk.Entry(frm_top, width=50)
entry_package.grid(row=1, column=1, padx=4, columnspan=2)

tk.Label(root, text='Paste JSON here:').pack(anchor='w', padx=8)
input_text = scrolledtext.ScrolledText(root, width=80, height=18)
input_text.pack(padx=8, pady=4)

btn_frame = tk.Frame(root)
btn_frame.pack(fill='x', padx=8)
tk.Button(btn_frame, text='Generate Kotlin Theme', command=lambda : generate_kotlin(True)).pack(side='left')
tk.Button(btn_frame, text='Generate Kotlin Color', command=lambda : generate_kotlin(False)).pack(side='left')
tk.Button(btn_frame, text='Save .kt', command=save_kotlin_file).pack(side='left', padx=6)
tk.Button(btn_frame, text='Copy to clipboard', command=copy_to_clipboard).pack(side='left', padx=6)
tk.Button(btn_frame, text='Clear', command=clear_all).pack(side='left', padx=6)

tk.Label(root, text='Generated Kotlin (Colors):').pack(anchor='w', padx=8, pady=(8,0))
output_text = scrolledtext.ScrolledText(root, width=80, height=18)
output_text.pack(padx=8, pady=(0,8))

root.mainloop()
