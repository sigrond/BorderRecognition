%%
layers = [imageInputLayer([480 640 3])
          convolution2dLayer(32,240)
          reluLayer()
          maxPooling2dLayer(2,'Stride',2)
          fullyConnectedLayer(10)
          softmaxLayer()
          classificationLayer()];
options = trainingOptions('sgdm');
%%
convnet = trainNetwork(X,Y,layers,options);