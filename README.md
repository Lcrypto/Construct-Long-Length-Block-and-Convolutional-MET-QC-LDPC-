# Construct-Long-Length-Block-and-Convolutional-MET-QC-LDPC-
This project contain toolchain source code for construction high perfomance long length, low error floor block Multi-edge Type (MET) QC-LDPC codes and Tail-Biting convolutional MET QC-LDPC Codes (MET QC-LDPCC codes) from articles Vasiliy Usatyuk und Ilya Vorobyev Construction of High Performance Block and Convolutional Multi-Edge Type QC-LDPC codes 42st International Conference on Telecommunications and Signal Processing (TSP) 2019,  1-3 July 2019, Budapest, Hungary.  https://ieeexplore.ieee.org/document/8769083




Folders:
1. protograph - protograph seach (currently have some limitation, full shall be uploaded after article publication, for reproduce result it enought) 
![alt text](https://ieeexplore.ieee.org/mediastore_new/IEEE/content/media/8764048/8768805/8769083/usaty6-049-large.gif)
2. SA Lifting (on figure it used for EMD MS, QRCBP, AdJs MS) - lifting protograph with optimization extrinsic message degree (EMD) for a cycle.
Our software maximize according all variable nodes: if maximal EMD for this variable node weight reached it consider nodes weight+1, .... Our version of EMD metric mean minimal value of EMD for maximal value of column weight which reached according current constructed graph. This simplify classification of graph properties without requirement write first elements of EMD spectrum, which could'nt be improved futher. If you prefer classical EMD spectrum analysis, just run tool with desire parameter of cycles https://github.com/Lcrypto/EMD-Spectrum-LDPC and use uncompressed metric. From my practice full description is redundant and require only if you interesting influence of you protograph cycles to linear size of trapping set which affect on waterfall. For long length codes under well optimized parameter of decoder waterfall depend mostly from threshold value.
3. make_MET_TB_LDPCC	- final construction of MET QC-LDPCC codes from block codes
4. Trapping_Sets - Chad Cole's Trapping set search and weighting (probabalistical and deterministical versions shall be upload after articles publish), binary files for search see at https://github.com/Lcrypto/trapping-sets-enumeration. 
5. Result - constructed block and convolutional MET QC-LDPC codes
![alt text](https://ieeexplore.ieee.org/mediastore_new/IEEE/content/media/8764048/8768805/8769083/usaty7-049-large.gif)
