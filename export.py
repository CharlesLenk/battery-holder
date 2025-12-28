from scad_export.export import export
from scad_export.exportable import Folder, Model

files=Folder(
    name='scad_export/battery_holder',
    contents=[
        Model(name='holder'),
        Model(name='symbol_insert')
    ]
)

export(files)
