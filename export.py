from scad_export.export import Folder, Model, export

files=Folder(
    name='scad_export/battery_holder',
    contents=[
        [Model(name='holder', columns=columns) for columns in range(4, 9, 2)],
        Model(name='symbol_insert')
    ]
)

export(files)
