def preprocess(i): i.data.events;
def tie(res): . // {} | . |= . + res | . |= . * {out: {(.name): .tagsList}};
def postprocess: .out | .[] |= (. | .[] += 1 | tostring);
foreach inputs as $input ({}; values | tie(preprocess($input)); .) | postprocess
