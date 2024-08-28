-- World ProcessID = "GvLWh-oAIsA9e5KF5WpsuPcErJQJMK8KuL_NBl5t-is"

--#region Model

RealityInfo = {
  Dimensions = 2,
  Name = 'ExampleReality',
  ['Render-With'] = '2D-Tile-0',
}

RealityParameters = {
  ['2D-Tile-0'] = {
    Version = 0,
    Spawn = { 5, 7 },
    -- This is a tileset themed to Llama Land main island
    Tileset = {
      Type = 'Fixed',
      Format = 'PNG',
      TxId = 'cYumeowVGKGjP4XT4sPJbgxRBSe1IMOt8D61EaQOqJ8', -- TxId of the tileset in PNG format
    },
    -- This is a tilemap of sample small island
    Tilemap = {
      Type = 'Fixed',
      Format = 'TMJ',
      TxId = 'lseN6pnIDi2GbbL2rLUaNIvVQWxSevdN-ESPUMZpZyU', -- TxId of the tilemap in TMJ format
      -- Since we are already setting the spawn in the middle, we don't need this
      -- Offset = { -10, -10 },
    },
  },
}

RealityEntitiesStatic = {
['SnGq0A1eXNK6iHdFKTr6h1X0EPlnfpNE9GlUnswERPc'] = {
        Type = "Avatar",
        Position = { 8, 8 }, --58,44
        Metadata = {
            DisplayName = "Jolly Jester",
            -- SkinNumber = 5,
           SpriteTxId   ="KvuWeGSjHJUpqN5tQiH8UFKGtBnn236kioRwkR2dwno",
            Interaction = {
                Type = 'SchemaForm',
                Id = "Jolly Jester"
            },
        },
    },

}

--#endregion

return print("Loaded Reality Template")
