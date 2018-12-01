void reset(){
  int pickPreset = (int)random(presets.length);
  store = presets[pickPreset];
}
