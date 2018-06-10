float activationFunction(float x) {
  //if(x>0)return 1;
  //return -1;
  return x;
  //return 1/(1+exp(-6*x));
}
Neuron neuronFromJSON(JSONObject obj){
  Neuron n=new Neuron();
  n.offset=obj.getFloat("offset");
  JSONArray arr=obj.getJSONArray("weights");
  n.weights=new float[arr.size()];
  for(int i=0;i<arr.size();i++){
    n.weights[i]=arr.getFloat(i);
  }
  n.oper=obj.getInt("oper");
  return n;
}
class Neuron {
  int oper=0;
  int OP_ADD=0,OP_MULT=1;
  //TODO: is this neseccary?
  JSONObject toJSON(){
    JSONObject obj=new JSONObject();
    JSONArray arr=new JSONArray();
    for(float w:weights)arr.append(w);
    obj.setJSONArray("weights",arr);
    obj.setFloat("offset",offset);
    obj.setInt("oper",oper);
    return obj;
  }
  float offset=0;
  float value;
  float[]weights;
  protected Neuron(){}
  Neuron(int prevNum) {
    oper=random(100)<50?OP_ADD:OP_MULT;
    weights=new float[prevNum];
    for (int i=0; i<prevNum; i++) {
      weights[i]=random(-0.5, 0.5);
    }
  }
  void calc(Neuron[]lastLayer) {
    value=0;
    for (int i=0; i<lastLayer.length; i++) {
      if(oper==OP_ADD)value+=weights[i]*lastLayer[i].value;
      else value*=weights[i]*lastLayer[i].value;;
    }
    value+=offset;
    
    value=activationFunction(value);
  }
  Neuron vary(float variance) {
    Neuron n=new Neuron(weights.length);
    for (int i=0; i<weights.length; i++) {
      n.weights[i]=random(-variance, variance)+weights[i];
    }
    return n;
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
  Layer vary(float variance) {
    Layer l=new Layer(n, pn);
    for (int i=0; i<n; i++) {
      l.neurons[i]=neurons[i].vary(variance);
    }
    return l;
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
  Network vary(float variance) {
    Network n=new Network(numInputs, numLayers, numHidden, numOutput);
    for (int i=0; i<numLayers; i++) {
      n.layers[i]=layers[i].vary(variance);
    }
    n.outputLayer=outputLayer.vary(variance);
    return n;
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