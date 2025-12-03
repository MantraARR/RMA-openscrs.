from reportlab.lib import colors
from reportlab.lib.pagesizes import letter
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.platypus import SimpleDocTemplate, Paragraph, Spacer, Image, Table, TableStyle
from reportlab.lib.units import inch

# Paths to uploaded images
images = [
    "/mnt/data/file_00000000a59c72309d98100d1435b04d",  # Henry James portrait
    "/mnt/data/file_000000000b407230942dea0083a50be1",  # Venice canal
    "/mnt/data/file_000000008a047230b9e76345ad51bbc4"   # Letters
]

# Output PDF path
pdf_path = "/mnt/data/The_Aspern_Papers_OnePager.pdf"
doc = SimpleDocTemplate(pdf_path, pagesize=letter)

# Styles
styles = getSampleStyleSheet()
title_style = ParagraphStyle('TitleStyle', parent=styles['Title'], textColor=colors.darkblue, alignment=1, fontSize=22, leading=26)
section_title = ParagraphStyle('SectionTitle', parent=styles['Heading2'], textColor=colors.darkred, fontSize=14, spaceAfter=6)
text_style = ParagraphStyle('TextStyle', parent=styles['Normal'], fontSize=11, leading=14, textColor=colors.black)

content = []

# Title
content.append(Paragraph("The Aspern Papers – One Pager", title_style))
content.append(Spacer(1, 10))
content.append(Paragraph("<b>Author:</b> Henry James", text_style))
content.append(Paragraph("<b>Student Name:</b> ____________________ &nbsp;&nbsp; <b>Date:</b> ____________ &nbsp;&nbsp; <b>Period:</b> ____", text_style))
content.append(Spacer(1, 12))

# Add image table
img_table_data = [[
    Image(images[0], width=1.5*inch, height=2*inch),
    Image(images[1], width=3.2*inch, height=2*inch),
    Image(images[2], width=1.5*inch, height=2*inch)
]]
img_table = Table(img_table_data)
img_table.setStyle(TableStyle([('ALIGN', (0,0), (-1,-1), 'CENTER'),
                               ('VALIGN', (0,0), (-1,-1), 'MIDDLE')]))
content.append(img_table)
content.append(Spacer(1, 10))

# Summary
content.append(Paragraph("1. One-Paragraph Summary", section_title))
summary_text = ("In <i>The Aspern Papers</i>, an unnamed narrator—an ambitious literary scholar—travels to Venice in hopes of obtaining "
                "the private papers of a deceased poet, Jeffrey Aspern, from the aging woman who once loved him, Juliana Bordereau. "
                "The narrator rents rooms in her decaying palazzo under false pretenses, growing increasingly obsessed with the papers "
                "and Juliana’s niece, Miss Tina. His deception eventually unravels, and in his greed for literary fame, he loses both "
                "the papers and any hope of redemption.")
content.append(Paragraph(summary_text, text_style))
content.append(Spacer(1, 8))

# Characters
content.append(Paragraph("2. Key Characters", section_title))
char_text = ("<b>The Narrator:</b> A cunning and obsessive scholar whose moral blindness exposes the dangers of intellectual vanity.<br/>"
             "<b>Juliana Bordereau:</b> Aspern’s former lover, reclusive and proud, guarding his legacy.<br/>"
             "<b>Miss Tina:</b> Juliana’s timid niece, torn between loyalty and affection.<br/>"
             "<b>Jeffrey Aspern:</b> A Romantic poet whose unseen presence drives the plot.")
content.append(Paragraph(char_text, text_style))
content.append(Spacer(1, 8))

# Setting
content.append(Paragraph("3. Setting", section_title))
set_text = ("<b>Time:</b> Late 19th century<br/>"
            "<b>Place:</b> Venice, Italy – primarily inside a crumbling Venetian palazzo.<br/>"
            "<b>Atmosphere:</b> Gloomy, secretive, and decaying.<br/>"
            "<b>Social Conditions:</b> Reflects society’s obsession with fame and artistic legacy.")
content.append(Paragraph(set_text, text_style))
content.append(Spacer(1, 8))

# Literary Devices
content.append(Paragraph("4. Literary Devices", section_title))
lit_text = ("<b>Symbolism:</b> The decaying palazzo represents moral decay and corruption.<br/>"
            "<b>Irony:</b> The narrator’s quest to preserve Aspern’s legacy destroys it.<br/>"
            "<b>Foreshadowing:</b> Juliana’s suspicion predicts the narrator’s failure.<br/>"
            "<b>Imagery:</b> “The room was dusky and faded, with old Venetian blinds that kept out the sun.” (James, Ch. 2)")
content.append(Paragraph(lit_text, text_style))
content.append(Spacer(1, 8))

# Quotes
content.append(Paragraph("5. Two Important Quotes", section_title))
quotes_text = ("“I was prepared to pay for my prize, but I was not prepared to pay with my soul.”<br/>"
               "→ Reveals the narrator’s internal conflict.<br/><br/>"
               "“She was like a ghost guarding the ashes of her dead.”<br/>"
               "→ Shows Juliana’s haunting devotion and secrecy.")
content.append(Paragraph(quotes_text, text_style))
content.append(Spacer(1, 8))

# Author's Purpose
content.append(Paragraph("6. Author’s Purpose", section_title))
purpose_text = ("Henry James explores the ethical boundaries of art, privacy, and obsession. Through the narrator’s moral decline, "
                "he critiques the possessive nature of scholarship and asks whether art belongs to the world or to those who lived it.")
content.append(Paragraph(purpose_text, text_style))
content.append(Spacer(1, 10))

# Visual Design
content.append(Paragraph("🎨 Design Concept", section_title))
visual_text = ("Use deep blues, sepia tones, and gold to capture Venice’s decaying beauty. "
               "Add motifs of eyes or letters to represent secrecy and obsession. "
               "Include a pen or key as symbols of intrusion and discovery.")
content.append(Paragraph(visual_text, text_style))

# Build PDF
doc.build(content)

pdf_path
