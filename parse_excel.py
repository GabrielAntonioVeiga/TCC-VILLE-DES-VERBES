import zipfile
import xml.etree.ElementTree as ET

doc = zipfile.ZipFile('Planejamento de sprints.xlsx')
ss = []
for p in ET.XML(doc.read('xl/sharedStrings.xml')).iter():
    if p.tag.endswith('}t'):
        ss.append(p.text or '')

sheets = [f for f in doc.namelist() if f.startswith('xl/worksheets/')]
out = ''
for s in sheets:
    out += f'--- {s} ---\n'
    root = ET.XML(doc.read(s))
    for r in root.iter('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}row'):
        row_cells = []
        for c in r.findall('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}c'):
            v = c.find('{http://schemas.openxmlformats.org/spreadsheetml/2006/main}v')
            val = ''
            if v is not None and v.text:
                if c.attrib.get('t') == 's':
                    val = ss[int(v.text)]
                else:
                    val = v.text
            row_cells.append(str(val).replace(',', ';').replace('\n', ' '))
        out += ','.join(row_cells) + '\n'

with open('reqs.csv', 'w', encoding='utf-8') as f:
    f.write(out)
