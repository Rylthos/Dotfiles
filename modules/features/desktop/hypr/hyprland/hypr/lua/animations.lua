hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1.0 } } })
hl.curve("linear",         { type = "bezier", points = { { 0.0, 0.0 }, { 1.0, 1.0 } } })

hl.curve("spring_window",    { type = "spring", mass = 1,   stiffness = 30, dampening = 8  })
hl.curve("spring_open",      { type = "spring", mass = 1,   stiffness = 30, dampening = 8  })
hl.curve("spring_workspace", { type = "spring", mass = 1.2, stiffness = 30, dampening = 10 })

hl.animation({ leaf = "windows", enabled = true, speed = 1, spring = "spring_window" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 1, spring = "spring_open", style="popin 40%" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "spring_workspace", style="slide" })
