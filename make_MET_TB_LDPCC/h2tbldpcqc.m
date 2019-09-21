
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

function [H,H1, n,m,z] = h2tbldpcqc(tbldpcFileName,numberOfCopies,qc_file)

fid = fopen(tbldpcFileName, 'r');

n = fscanf(fid, '%d', [1 1]);
m = fscanf(fid, '%d', [1 1]);
z = fscanf(fid, '%d', [1 1]);
shift = fix(n / m);
residue = mod(n, m);
I = sparse(eye(z));
Z = sparse(zeros(z));
%H0 = sparse([]);

H0 = (fscanf(fid, '%d', [n m]))';
H00 = [];
for j = 1 : m
	cur_shift = (j - 1) * shift + min(residue, j - 1);
    H00 = [H00; circshift(H0(j, :), [0 -cur_shift])];
end
H00;
H00 = [H00 (zeros(m, n * (numberOfCopies - 1)) - ones(m, n * (numberOfCopies - 1)))];
H1 = [];
%Hr = [H0, 1:1, 1:n*numberOfCopies]
for i = 1 : numberOfCopies
    for j = 1 : m
        cur_shift = (i - 1) * n + (j - 1) * shift + min(residue, j - 1);
        H1 = [H1; circshift(H00(j, :), [0 cur_shift])];
    end
end

        

H = sparse([]);
for i = 1:m*numberOfCopies
    lH = sparse([]);
    for j = 1:n*numberOfCopies
        circ_shift = H1(i,j);
        if circ_shift == -1
            lH = [lH Z];
        else
            lH = [lH circshift(I, circ_shift)];
        end
    end
    H = [H; lH];
end
n = n * numberOfCopies;
m = m * numberOfCopies;
fclose(fid);


 
    H = full(H1);
    file = fopen(qc_file, 'w');
    fprintf(file, '%d %d %d\n', n, m, z);
    for i = 1:m
        fprintf(file, '%d ', H(i, :));
        fprintf(file, '\n');
    end
    fclose(file);




% H1
end
