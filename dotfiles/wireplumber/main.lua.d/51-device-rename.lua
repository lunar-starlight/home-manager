rule1 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.*.pro-output-4" },
    },
  },
  apply_properties = {
    ["node.description"] = "Headphones",
  },
}

rule2 = {
  matches = {
    {
      { "node.name", "matches", "alsa_output.*.pro-output-0" },
    },
  },
  apply_properties = {
    ["node.description"] = "Amp",
  },
}


table.insert(alsa_monitor.rules, rule1)
table.insert(alsa_monitor.rules, rule2)
