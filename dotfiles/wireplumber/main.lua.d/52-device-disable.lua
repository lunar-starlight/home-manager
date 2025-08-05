rule = {
  matches = {
    {
      { "node.name", "equals", "alsa_output.pci-0000_09_00.3.pro-output-1" },
    },
  },
  apply_properties = {
    ["node.disabled"] = true,
  },
}

table.insert(alsa_monitor.rules,rule)
