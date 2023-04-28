# Construct-Long-Length-Block-and-Convolutional-MET-QC-LDPC-
This project provides a toolchain source code for constructing high-performance, long-length, and low-error floor block Multi-edge Type (MET) QC-LDPC codes and tail-biting convolutional MET QC-LDPC codes. The codes are constructed based on articles by Vasiliy Usatyuk and Ilya Vorobyev titled "Construction of High Performance Block and Convolutional Multi-Edge Type QC-LDPC codes" presented at the 42nd International Conference on Telecommunications and Signal Processing (TSP) in July 2019 in Budapest, Hungary. The paper can be found at https://ieeexplore.ieee.org/document/8769083.






1. The "protograph" folder contains the protograph search tool. Please note that it currently has some limitations, and the full version will be uploaded after the publication of the corresponding article. However, it should be enough to reproduce the results.
![alt text](https://ieeexplore.ieee.org/mediastore_new/IEEE/content/media/8764048/8768805/8769083/usaty6-049-large.gif)


2. SA Lifting (on figure it used for EMD MS, QRCBP, AdJs MS) - lifting protograph with optimization extrinsic message degree (EMD) for a cycle.
Our software maximize according all variable nodes: if maximal EMD for this variable node weight reached it consider nodes weight+1, .... Our version of EMD metric mean minimal value of EMD for maximal value of column weight which reached according current constructed graph. This simplify classification of graph properties without requirement write first elements of EMD spectrum, which could'nt be improved futher. If you prefer classical EMD spectrum analysis, just run tool with desire parameter of cycles https://github.com/Lcrypto/EMD-Spectrum-LDPC and use uncompressed metric. From our experience, a full description is only necessary if you are interested in knowing the influence of your protograph cycles on the linear size of the trapping set, which affects the waterfall. For long-length codes under well-optimized decoder parameters, the waterfall depends mostly on the threshold value.



"If you prefer classical EMD spectrum analysis, you can use the tool available at https://github.com/Lcrypto/EMD-Spectrum-LDPC with the desired parameter of cycles and use the uncompressed metric. However, based on our experience, a full description is only necessary if you are interested in understanding the influence of your protograph cycles on the linear size of the trapping set that affects the waterfall. For long-length codes under well-optimized decoder parameters, the waterfall mostly depends on the threshold value."
3. "make_MET_TB_LDPCC" is the tool used for the final construction of MET QC-LDPCC codes from block codes.
4. "Trapping_Sets" is the tool used for Chad Cole's Trapping sets search and weighting. Binary files for the search can be found at https://github.com/Lcrypto/trapping-sets-enumeration.
5. Result - constructed block and convolutional MET QC-LDPC codes
![alt text](https://ieeexplore.ieee.org/mediastore_new/IEEE/content/media/8764048/8768805/8769083/usaty7-049-large.gif)
