require('nvim-web-devicons').setup {
    default = true
}

local textIcon = require'nvim-web-devicons'.get_icons()[1] -- Default
textIcon.name = "Text"

require'nvim-web-devicons'.set_icon {
    txt = textIcon
}
