float activationFunction(float x) {
  //if(x>0)return 1;
  //return -1;
  //return x;
  //return -1;
  return 2.0/(1.0+exp(-6.0*x))-1.0;
}
Neuron neuronFromJSON(JSONObject obj){
  Neuron n=new Neuron();
  n.offset=obj.getFloat("offset");
  JSONArray arr=obj.getJSONArray("weights");
  n.weights=new float[arr.size()];
  for(int i=0;i<arr.size();i++){
    n.weights[i]=arr.getFloat(i);
  }
  return n;
}
class Neuron {
  //TODO: is this neseccary?
  JSONObject toJSON(){
    JSONObject obj=new JSONObject();
    JSONArray arr=new JSONArray();
    for(float w:weights)arr.append(w);
    obj.setJSONArray("weights",arr);
    obj.setFloat("offset",offset);
    return obj;
  }
  float offset=0;
  float value;
  float[]weights;
  protected Neuron(){}
  int oper;
  int O_ADD=0;
  int O_MULT=1;
  Neuron(int prevNum) {
    weights=new float[prevNum];
    for (int i=0; i<prevNum; i++) {
      weights[i]=random(-1.0, 1.0);
    }
    oper=random(100)<50?O_ADD:O_MULT;
    offset=random(-1.0,1.0);
  }
  Neuron makeNew(){
    Neuron n=new Neuron(weights.length);
    n.offset=offset;
    n.value=value;
    for(int i=0;i<weights.length;i++){
      n.weights[i]=weights[i];
    }
    n.oper=oper;
    return n;
  }
  void calc(Neuron[]lastLayer) {
    value=0;
    for (int i=0; i<lastLayer.length; i++) {
      value+=weights[i]*lastLayer[i].value;
      //value*=weights[i]*lastLayer[i].value;;
    }
    value+=offset;
    
    value=activationFunction(value);
  }
  //Neuron vary(float variance) {
  //  Neuron n=new Neuron(weights.length);
  //  n.offset=offset;
  //  n.value=value;
  //  n.weights=new float[weights.length];
  //  for (int i=0; i<weights.length; i++) {
  //    n.weights[i]=weights[i]+random(-variance,variance);//offset into the new neuron
  //  }
  //  n.offset=offset+random(-variance,variance);
  //  return n;
  //}
  void varyInPlace(){
    for(int i=0;i<weights.length;i++){
      weights[i]+=random(-NEURON_WEIGHTS_VARY,NEURON_WEIGHTS_VARY);
    }
    offset+=random(-NEURON_OFFSET_VARY,NEURON_OFFSET_VARY);
  }
}
Layer layerFromJSON(JSONObject obj){
  Layer l=new Layer();
  JSONArray arr=obj.getJSONArray("neurons");
  l.neurons=new Neuron[arr.size()];
  l.n=obj.getInt("n");
  l.pn=obj.getInt("pn");
  for(int i=0;i<arr.size();i++){
    l.neurons[i]=neuronFromJSON(arr.getJSONObject(i));
  }
  return l;
}
class Layer {
  JSONObject toJSON(){
    JSONObject obj=new JSONObject();
    JSONArray arr=new JSONArray();
    for(Neuron n:neurons)arr.append(n.toJSON());
    obj.setJSONArray("neurons",arr);
    obj.setInt("n",n);
    obj.setInt("pn",pn);
    return obj;
  }
  Neuron[]neurons;
  protected Layer() {
  }
  int n, pn;
  Layer(int num, int prevNum) {
    n=num;
    pn=prevNum;
    neurons=new Neuron[num];
    for (int i=0; i<num; i++) {
      neurons[i]=new Neuron(prevNum);
    }
  }
  void calc(Layer lastLayer) {
    for (Neuron n : neurons) {
      n.calc(lastLayer.neurons);
    }
  }
  Layer makeNew(){
    Layer l=new Layer(n,pn);
    l.n=n;
    l.pn=pn;
    for(int i=0;i<n;i++)l.neurons[i]=neurons[i].makeNew();
    return l;
  }
  //Layer vary(float variance) {
  //  Layer l=new Layer(n, pn);
  //  l.n=n;
  //  l.pn=pn;
  //  for (int i=0; i<n; i++) {
  //    l.neurons[i]=neurons[i].vary(variance);
  //  }
  //  return l;
  //}
  void varyInPlace(){
    for(int i=0;i<neurons.length;i++){
      neurons[i].varyInPlace();
    }
  }
}
class InputLayer extends Layer {
  float[]inputs;
  InputLayer(int numInputs) {
    inputs=new float[numInputs];
    neurons=new Neuron[numInputs];
  }
  InputLayer(){}
  void initNeurons() {
    for (int i=0; i<inputs.length; i++) {
      neurons[i]=new Neuron(0);
      neurons[i].value=activationFunction(inputs[i]);
    }
  }
  void calc() {
  }
}
Network networkFromJSON(JSONObject obj){
  Network n=new Network(obj.getInt("numInputs"),obj.getInt("numLayers"),obj.getInt("numHidden"),obj.getInt("numOutput"));
  JSONArray arr=obj.getJSONArray("layers");
  for(int i=0;i<arr.size();i++){
    n.layers[i]=layerFromJSON(arr.getJSONObject(i));
  }
  n.outputLayer=layerFromJSON(obj.getJSONObject("outputLayer"));
  return n;
}
class Network {
  JSONObject toJSON(){
    JSONObject obj=new JSONObject();
    obj.setInt("numInputs",numInputs);
    obj.setInt("numLayers",numLayers);
    obj.setInt("numHidden",numHidden);
    obj.setInt("numOutput",numOutput);
    JSONArray arr=new JSONArray();
    for(Layer l:layers)arr.append(l.toJSON());
    obj.setJSONArray("layers",arr);
    obj.setJSONObject("outputLayer",outputLayer.toJSON());
    return obj;
  }
  InputLayer inputLayer;
  Layer[] layers;
  Layer outputLayer;
  int numInputs;
  int numLayers;
  int numHidden;
  int numOutput;
  Network makeNew(){
    Network n=new Network(numInputs,numLayers,numHidden,numOutput);
    //n.inputLayer=inputLayer.makeNew();
    for(int i=0;i<numLayers;i++)n.layers[i]=layers[i].makeNew();
    n.outputLayer=outputLayer.makeNew();
    return n;
  }
  Network(int numInputs, int numLayers, int numHidden, int numOutput) {//numHidden is number of hidden neurons per layer
    inputLayer=new InputLayer(numInputs);
    this.numLayers=numLayers;
    this.numHidden=numHidden;
    this.numInputs=numInputs;
    this.numOutput=numOutput;
    inputLayer=new InputLayer(numInputs);
    layers=new Layer[numLayers];
    layers[0]=new Layer(numHidden, numInputs);
    for (int i=1; i<numLayers; i++) {
      layers[i]=new Layer(numHidden, numHidden);
    }
    outputLayer=new Layer(numOutput, numHidden);
  }
  void calc(float[]inputs) {
    inputLayer.inputs=inputs;
    inputLayer.initNeurons();
    layers[0].calc(inputLayer);
    for (int i=1; i<numLayers; i++) {
      layers[i].calc(layers[i-1]);
    }
    outputLayer.calc(layers[numLayers-1]);
  }
  float[]getOutputs() {
    float[]outputs=new float[numOutput];
    for (int i=0; i<numOutput; i++) {
      outputs[i]=outputLayer.neurons[i].value;
    }
    return outputs;
  }
  float out(int ind) {
    return getOutputs()[ind];
  }
  //Network vary(float variance) {
  //  Network n=new Network(numInputs, numLayers, numHidden, numOutput);
  //  n.inputLayer=inputLayer;
  //  for (int i=0; i<numLayers; i++) {
  //    n.layers[i]=layers[i].vary(variance);
  //  }
  //  n.outputLayer=outputLayer.vary(variance);
  //  return n;
  //}
  void varyInPlace(){
    for(int i=0;i<numLayers;i++){
      layers[i].varyInPlace();
    }
    outputLayer.varyInPlace();
  }
  //Wants least error
  float checkResult(Result r) {
    calc(r.inputs);
    float[]outputs=getOutputs();
    float error=0;
    for (int i=0; i<numOutput; i++) {
      error+=abs(r.outputs[i]-outputs[i]);
    }
    return error;
  }
  float checkResult(Result[]results) {
    float error=0;
    for (Result r : results)error+=checkResult(r);
    return error;
  }
}

class Result {
  float[]inputs;
  float[]outputs;
}