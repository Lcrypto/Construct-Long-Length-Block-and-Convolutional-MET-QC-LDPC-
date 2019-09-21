%Copyright(c) 2012, USAtyuk Vasiliy 
%All rights reserved.
%
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
%
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

function [SNR]=getThresholdsRobust(iter,S, leEN,riEN,pun, short,inner, approx,level,type,layered,Samples)

% S=[1 0 0 0 0 0 0 0 0 1 2 0 0 0 0 0 0;
%    0 1 3 2 1 2 1 2 1 2 1 0 0 0 0 0 0;
%    0 1 0 1 2 1 2 1 2 1 2 0 0 0 0 0 0;
%    0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0;
%    0 0 0 0 0 1 1 1 1 1 2 0 1 0 0 0 0;
%    0 0 0 0 1 1 1 1 1 1 2 0 0 1 0 0 0;
%    0 0 1 0 0 0 1 1 1 1 2 0 0 0 1 0 0;
%    0 0 1 0 0 1 1 0 1 0 2 0 0 0 0 1 0;
%    0 0 1 0 0 0 1 0 1 0 1 0 0 0 0 0 1];
    iterations=iter;%number of decoding iterations
	%pun=[11]; %puncture nodes
	samples=Samples;%number of samples(Monte Carlo) to make smooth estimation of iterative decoding treshold
	%leEN=0;
	%riEN=2;
    [m n]=size(S);
    pun = cell2mat(pun);
	R=(n-m)/(n-length(pun));




while( ~pexit(S,riEN,R,pun,iterations,level))
    leEN=riEN;
    riEN=riEN+1;
%     disp(num2str(riEN))
end
for L=1:1:samples 
    midEN=(riEN+leEN)/2;
%     disp(num2str(midEN))
%     if pexit(S,midEN,R)
    if pexit(S,midEN,R,pun,iterations,level)
        riEN=midEN;
    else
        leEN=midEN;
    end
end
midEN=(riEN+leEN)/2; %Eb/No
SNR = midEN + 10*log10(log2(4)*R); %SNR
end
% S=[1 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0;
%    0 1 1 1 3 1 3 1 3 1 3 0 0 0 0 0 0;
%    0 1 2 2 1 3 1 3 1 3 1 0 0 0 0 0 0;
%    0 0 0 0 0 0 1 1 1 1 1 1 0 0 0 0 0;
%    0 0 0 0 0 1 1 1 1 1 2 0 1 0 0 0 0;
%    0 0 0 0 1 1 1 1 1 1 2 0 0 1 0 0 0;
%    0 0 1 0 0 0 1 1 1 1 2 0 0 0 1 0 0;
%    0 0 1 0 0 1 1 0 1 0 2 0 0 0 0 1 0;
%    0 0 1 0 0 0 1 0 1 0 1 0 0 0 0 0 1];
