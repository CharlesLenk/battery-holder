from scad_export.export import Folder, Model, export

files=Folder(
    name='scad_export/battery_holder',
    contents=[
        Folder(
            name='AA_holder',
            contents=[
                [Model(name='holder', columns=columns, battery_type="AA") for columns in range(4, 9, 2)],
                Model(name='symbol_insert', battery_type="AA")
            ]
        ),
        Folder(
            name='AAA_holder',
            contents=[
                [Model(name='holder', columns=columns, battery_type="AAA") for columns in range(4, 9, 2)],
                Model(name='symbol_insert', battery_type="AAA")
            ]
        )
    ]
)

export(files)
