import tkinter as tk
from tkinter import scrolledtext
import re
import os
import pyperclip

xmlGeneral = ""

def nettoyer_option(texte):
    # txt = re.sub(r"^[•]\s*", "", texte)
    return re.sub(r"^[A-Da-d](?:\)|\.)\s*", "", texte.replace("•",'').replace('✅', '').replace('-', '').strip()).strip()

def separer_questions(texte):
    questions = re.split(r'\n\s*\d+\.', texte)
    questions_separees = [q.strip() for q in questions if q.strip() != '']
    return questions_separees

def copier_dans_presse_papier() :
    pyperclip.copy(generer_xml())
    # os.system(f'echo "{generer_xml()}" | clip')

    
def vider() :
    input_text.delete("1.0", tk.END)

def convertir_bloc_qcm(texte, prefixe):
    # blocs = texte.strip().split('\n\n')  # Séparer plusieurs questions
    blocs = separer_questions(texte)  # Séparer plusieurs questions
    # print(blocs)
    xml_total = ""
    numero = 1
    
    for bloc in blocs:
        lignes = bloc.strip().split('\n')
        if not lignes or len(lignes) < 2:
            continue

        en_tete = lignes[0]
        try:
            numeroo, question = en_tete.split('.', 1)
        except ValueError:
            question = en_tete

        # numero = numero.strip()
        question = question.strip()

        options = []
        bonne_reponse_index = -1

        for i, ligne in enumerate(lignes[1:]):
            option = nettoyer_option(ligne)
            if '✅' in ligne:
                bonne_reponse_index = i
            options.append(option)

        nom_base = f"{prefixe}_{numero}"

        xml = f'\t<string name="{nom_base}">{question}</string>\n'
        xml += f'\t<string name="{nom_base}_reponse_valid">{bonne_reponse_index}</string>\n'
        xml += f'\t<string-array name="{nom_base}_reponses">\n'
        for opt in options:
            xml += f'\t    <item>{opt}</item>\n'
        xml += '\t</string-array>\n\n'

        numero += 1
        xml_total += xml
        # print(xml_total)
    
    numero = 0
    return xml_total.strip()

# Interface Tkinter
def generer_xml():
    rubrique = entry_rubrique.get().strip().lower()
    niveau = entry_niveau.get().strip().lower()
    texte = input_text.get("1.0", tk.END)

    prefixe = f"{rubrique}_{niveau}_question"
    xml = convertir_bloc_qcm(texte, prefixe)
    
    output_text.delete("1.0", tk.END)
    output_text.insert(tk.END, xml)

    return xml

# Fenêtre principale
fenetre = tk.Tk()
fenetre.title("Générateur XML - QCM")

tk.Label(fenetre, text="Rubrique :").grid(row=0, column=0, sticky="e")
entry_rubrique = tk.Entry(fenetre)
entry_rubrique.grid(row=0, column=1)

tk.Label(fenetre, text="Niveau :").grid(row=1, column=0, sticky="e")
entry_niveau = tk.Entry(fenetre)
entry_niveau.grid(row=1, column=1)

tk.Label(fenetre, text="Questions (brutes) :").grid(row=2, column=0, columnspan=3)
input_text = scrolledtext.ScrolledText(fenetre, width=60, height=15)
input_text.grid(row=3, column=0, columnspan=3)

tk.Button(fenetre, text="Générer XML", command=generer_xml).grid(row=4, column=0)
tk.Button(fenetre, text="Copier XML", command=copier_dans_presse_papier).grid(row=4, column=1)
tk.Button(fenetre, text="Vider", command=vider).grid(row=4, column=2)

tk.Label(fenetre, text="Résultat XML :").grid(row=5, column=0, columnspan=3)
output_text = scrolledtext.ScrolledText(fenetre, width=60, height=15)
output_text.grid(row=6, column=0, columnspan=3)

fenetre.mainloop()
