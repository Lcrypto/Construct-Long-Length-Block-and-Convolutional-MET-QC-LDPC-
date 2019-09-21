%
%Copyright(c) 2013,  Vasiliy Usatyuk
%All rights reserved.
%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met :
%*Redistributions of source code must retain the above copyright
%notice, this list of conditions and the following disclaimer.
%* Redistributions in binary form must reproduce the above copyright
%notice, this list of conditions and the following disclaimer in the
%documentation and / or other materials provided with the distribution.
%* Neither the name of the <organization> nor the
%names of its contributors may be used to endorse or promote products
%derived from this software without specific prior written permission.
%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
%ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
%WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED.IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
%DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
%(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
%ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
%(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
%SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%
% position in protograph for which place new edges defined in mask line 142
clear all
delete(gcp('nocreate'))
myStream=RandStream('mlfg6331_64');
rand(myStream);
degreeOfParallel = 2; %number of tread for protograph generating
protoVersion = 0;
approximation=2; % in limited version not work
Samples=50; % samples to make smooth threshold from  approx of J funct
%parpool(degreeOfParallel); %for parallel uncomment this line and line 249
iterationInPexit = 50;
targetBerPexit = 1e-5;
penForDisbCoef = 0.01;
%% find start matrix
proto = [
% AR4JA protograph with rate 4/5, last variable node punctured, just for compare
%1 0 0 0 0 0 0 0 0 0 2
%0 1 1 1 3 1 3 1 3 1 3
%0 1 2 2 1 3 1 3 1 3 1

%proposed protograph with rate 4/5 last 2 variable nodes punctured
0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	1	0	0	1
0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	1	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	1	0	0	1	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	1
0	0	1	1	0	0	0	0	1	0	1	0	1	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	1	0
0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	1	1	0	0	1	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	1	0	0	0	0	1	0	0	1	1
0	0	0	0	0	0	0	0	0	0	0	1	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	0	1	0	0	0	1	0	0	1	0	0	1	0	0	0	0	0	0	1	0	1	0	1	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	1	1
1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	1
0	1	0	0	1	0	1	1	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	1	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	1	0	0	0	1	1
0	0	0	0	0	0	0	0	0	1	0	1	0	0	1	0	1	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	1	1	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	1	1
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	1	1
0	1	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	1	0	0	1	1	0	0	0	1	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	1
0	1	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	1	0	1	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	1
0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	1	0	0	1	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	1	1	0	0	0	1	0	0	1	1	1
1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	1	0	0	0	1	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	1	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0
0	0	0	1	0	0	0	1	0	0	0	0	0	1	1	0	0	1	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	1	1	1	1
0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	1	1	0	1	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	1	0	1	0	0	1	1
0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	1	0	1	0	0	0	0	0	0	0	1	1
0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	1	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	1	0	0	0	0	0	0	0	1	0	0	1	0	1	0	1	0	0	0	0	1	0
0	0	0	0	0	1	1	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	1
0	0	0	0	0	1	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	1	1	0	0	0	0	1	0	0	0	0	0	0	0	1	1	0	0	0	1	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1
0	0	0	1	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	0	0	0	0	0	0	0	1	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1


    ];

layered = 0;
[rows, cols] = size(proto);
codeRates = [4/5];
rowsCollection = [20];
rowsForPexit = [20];
punByRates = [2];
shortByRates = [0];
coefFor4cyclesByRates = [0.01, 0.01, 0.01, 0.01] * 2;
coefForOnesByRates = [0];
numPunctNodes = zeros(1, length(rowsForPexit));
numShortNodes = zeros(1, length(rowsForPexit));
coefForOnes = zeros(1, length(rowsForPexit));
coefFor4cycles = zeros(1, length(rowsForPexit));
for i=1:length(rowsForPexit)
    for j=length(rowsCollection):-1:1
        if (rowsForPexit(i) <= rowsCollection(j))
            numPunctNodes(i) = punByRates(j);
            numShortNodes(i) = shortByRates(j);
            coefForOnes(i) = coefForOnesByRates(j);
            coefFor4cycles(i) = coefFor4cyclesByRates(j);
        end
    end
end

columnsForPexit = cols + (rowsForPexit - rows) ;
columnsCollection = cols + (rowsCollection - rows);

%% check Rates
for i = 1:length(codeRates)
    assert(codeRates(i) == (columnsCollection(i) - rowsCollection(i) - shortByRates(i)) /...
        (columnsCollection(i) - punByRates(i) - shortByRates(i)), 'CodeRate mismatch');
end
%%
coeffCollection = ones(1, length(rowsForPexit));

%% Parameters In Procedure
maxDifProtoInParforPexit = 2 * degreeOfParallel;
failsToStopInPexit = 1;
numberOfAttemptsForOneStep = 1;


% position in protograph for which place new edges
for j = 1:length(rowsForPexit)
    maskMatrix{j} = zeros(rowsForPexit(j), columnsForPexit(j));
    maskMatrix{j}(1:20,1:end) = 1;
end

% %% auxiliary
% for j = 1:length(rowsForPexit)
%     maskMatrix{j} = zeros(rowsForPexit(j), columnsForPexit(j));
%     if j == 1
%         maskMatrix{1}(:,rowsForPexit(1)+1:end) = 1;
%     else
%         if (rowsForPexit(j) == rowsForPexit(j- 1))
%             maskMatrix{j} = maskMatrix{j-1};
%         else
%             %maskMatrix{j}(1:(rowsCollection(j) - rowsCollection(j-1)),columnsCollection(j)-columnsCollection(j - 1)+1:end) = 1;
%             maskMatrix{j}(1:(rowsForPexit(j) - rowsForPexit(j-1)),columnsForPexit(j)-columnsForPexit(1)+1:end) = 1;
%         end
%     end
% end

meanNumOnes = 1.0;
for j = 1:length(maskMatrix)
    noisePr(j) = meanNumOnes / (sum(sum(maskMatrix{j})));
end


startProto = proto;

% indexRateDone = 1;
% bestProtoOnPreviousStage=proto;
% bestProto = bestProtoOnPreviousStage;
indexRateDone = 0;

bestCurLiftedMatrix = {};
while indexRateDone < length(rowsForPexit)
    coeff = coeffCollection(indexRateDone + 1);
    bestObjFun = 1000;
    for attId = 1:numberOfAttemptsForOneStep        
        
        threshold_search_gap_max = 10;
        
        if indexRateDone~= 0
            startProto = zeros(size(maskMatrix{indexRateDone + 1}));
            for i = 1:(rowsForPexit(indexRateDone + 1) - rowsForPexit(indexRateDone))
                
                    startProto(i,i) = 1;
            
            end
            startProto(end - rowsForPexit(indexRateDone) + 1:end, end - columnsForPexit(indexRateDone)+1:end) = bestProtoOnPreviousStage;
        end
        
        
        [rows,cols] = size(startProto);
        %rng(1*4444241+(1+numberOfAttemptsForOneStep*indexRateDone + attId)*37);
        noiseMtr = zeros(size(maskMatrix{indexRateDone + 1}));
        while (sum(sum(noiseMtr)) == 0)
            %noiseMtr = (rand(rows, cols) < (noisePr(indexRateDone + 1) *2).* maskMatrix{indexRateDone + 1});
            noiseMtr = (rand(rows, cols) < (noisePr(indexRateDone + 1) *2).* maskMatrix{indexRateDone + 1});
            noiseMtr = noiseMtr.* max(startProto, ones(size(startProto)));
            noiseMtr = noiseMtr.*(1 + 0 * fix(rand(rows, cols) * 3).* (rand(rows, cols) > 0.5));
        end
        proto = mod(startProto + noiseMtr, 2 );
        infoNodes = setdiff(1:cols, 1:rows);
        punctNodesInWhile = {};
        shortNodesInWhile = {};
        for i = 1:1
            punctNodesInWhile{i} = infoNodes(end -numPunctNodes(indexRateDone +i) +1:end);%randsample(infoNodes, numPunctNodes(indexRateDone +i));
            localSet = setdiff(infoNodes, punctNodesInWhile{i});
            shortNodesInWhile{i} = localSet(1:numShortNodes(indexRateDone + i));% randsample(localSet, numShortNodes(indexRateDone + i));
        end
        
        
%             initialThreshold = getThresholdsRobust(iterationInPexit,proto, ...
%                 -10, 10,...
%                 punctNodesInWhile,shortNodesInWhile,1,approximation, targetBerPexit, 0, layered);
         initialThreshold = getThresholdsRobust(iterationInPexit,proto, ...
                -10, 10,...
                punctNodesInWhile,shortNodesInWhile,1,approximation, targetBerPexit, 0, layered,Samples);
        
        penForDisbalance = 0;

        
        globalThreshold = initialThreshold;
        globalObjFun = sum(initialThreshold .* coeff, 2) + coefForOnes(indexRateDone + 1) * sum(sum(proto))...
            + coefFor4cycles(indexRateDone + 1) * get4cyclesByProto(proto > 0) + penForDisbalance * penForDisbCoef;
        threshold_search_gap = threshold_search_gap_max;
        noImpr = 0;
        tempr = 1;
        allIterations = 1;
        localBestProto = proto
        while true
            allIterations = allIterations + 1;
            tempr = 0.1 / allIterations;
            new_proto = zeros(rows, cols, 0);
            while size(new_proto, 3) < maxDifProtoInParforPexit
                noiseMtr = zeros(rows, cols);
                while (sum(sum(noiseMtr)) == 0)
                    noiseMtr = (rand(rows, cols) < (noisePr(indexRateDone + 1) * (1 + noImpr / (0.4 * failsToStopInPexit+1))).* maskMatrix{indexRateDone + 1});
                    
                    
                end
                newMtr = mod(proto + noiseMtr, 2 );
                if sum(sum(newMtr, 1)==0)
                    continue;
                end
                new_proto(:, :, 1 + size(new_proto, 3)) = newMtr;
            end
            thresholds = 100* ones(1, size(new_proto,3));
            for i=1:size(new_proto, 3)
            %parfor i=1:size(new_proto, 3)
            
                    thresholds(:, i) = getThresholdsRobust(iterationInPexit,new_proto(:,:,i), ...
                        globalThreshold - threshold_search_gap, globalThreshold + threshold_search_gap,...
                        punctNodesInWhile,shortNodesInWhile,1,approximation, targetBerPexit, 0, layered,Samples)
              
                
                objFun(i) = sum(thresholds(:, i).*coeff, 2) + coefForOnes(indexRateDone + 1) * sum(sum(new_proto(:,:,i))) + ...
                    coefFor4cycles(indexRateDone + 1) * get4cyclesByProto(new_proto(:,:,i) > 0) + penForDisbalance * penForDisbCoef;
            end
            [localObjFun,ind] = min(objFun);
            if (abs(localObjFun-globalObjFun)<1e-4 || localObjFun>globalObjFun) && (noImpr == failsToStopInPexit)
                break;
            end
            threshold_search_gap = min(threshold_search_gap_max, max(abs(localObjFun-globalObjFun)*2, 0.01))
            if (globalObjFun > 20)
                threshold_search_gap = 5;
            end
            if (globalObjFun > localObjFun)
                globalObjFun = localObjFun;
                globalThreshold = thresholds(:, ind);
                proto = new_proto(:,:,ind);
                localBestProto = proto;
                
                noImpr = 0;
            else
                p = rand();
                if (localObjFun < 30) && (p < exp(100 / (1 + 0.1*noImpr) *(globalObjFun - 1e-4 - localObjFun) / tempr))
                    
                    proto = new_proto(:,:,ind);
                    noImpr = 0;
                else
                    if mod(noImpr, 10) == 0
                        
                    end
                    noImpr = noImpr + 1;
                end
            end
        end
        
        
        fprintf('rows = %d cols = %d threshold = %f\n', rowsForPexit(indexRateDone + 1), columnsForPexit(indexRateDone + 1), globalThreshold);
        
        if globalObjFun < bestObjFun
            bestObjFun = globalObjFun;
            thresholdInBestObjFun = globalThreshold
            bestProto = proto;
        end
        
    end
    bestProtoOnPreviousStage = bestProto;
    fprintf('rows = %d cols = %d best object function = %f threshold = %f\n', ...
        rowsForPexit(indexRateDone + 1), columnsForPexit(indexRateDone + 1), bestObjFun, thresholdInBestObjFun);
    indexRateDone = indexRateDone + 1;
end


[rows, cols] = size(bestProto);
fid = fopen(['proto', num2str(cols), 'x', num2str(rows), 'ver', num2str(version)], 'w');
fprintf(fid, '%d\t%d\n', cols, rows);
for r = 1:rows
    fprintf(fid, '%d\t', bestProto(r, :));
    fprintf(fid, '\n');
end
fclose(fid);
