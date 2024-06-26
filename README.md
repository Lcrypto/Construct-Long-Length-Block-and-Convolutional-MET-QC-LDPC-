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



**In all simulation figures, we utilized 2-bit (ENOB) soft demodulator results within a 4-bit grid (ADCs). It's important to note that this approach employs the simplest soft demodulator. Further simplification to a 1-bit demodulator is only effective for hard decoders, such as the Bit-flipping decoder available at GitHub - [Bit-flipping Decoder](https://github.com/Lcrypto/LDPC-Iterative-Bit-Flipping-family-decoders). For scenarios involving such decoders, it is advisable to employ specially constructed codes, which can be found at GitHub - [Algebraic QC-LDPC Codes](https://github.com/Lcrypto/Algebraic_QC-LDPC ). This choice of decoder and code construction plays a crucial role in the performance of the simulations.**


It is strongly recommended to improve not only the EMD spectrum but also the code (Hamming) distance, see https://github.com/Lcrypto/Length-und-Rate-adaptive-code . 



In practice, we use the Lattice-based method (Kannan embeding, SVP, SBP, Block Korkin-Zolotarev, BKZ for solution Shortest Basis Problem) to achieve this goal, but you can use Dumer or Brouwer-Zimmerman implementation from GAP/MAGMA.
According to our (Usatyuk Vasiliy) results in the code distance challenge at https://decodingchallenge.org/low-weight/, Lattice methods are superior:
![alt text](https://github.com/Lcrypto/Length-und-Rate-adaptive-code/blob/master/Code_distance_challenge.png)

Lattice method for code (Hamming) distance estimation:




1.  Usatyuk V. S., Egorov S. I., "Heuristic Number Geometry Method for Finding Low-Weight Codeword in Linear Block Codes," 2024 26th International Conference on Digital Signal Processing and its Applications (DSPA), Moscow, Russian Federation, 2024, pp. 1-6  https://ieeexplore.ieee.org/document/10510086


2.  Usatyuk V.S., E. Sergey and G. Svistunov, "Construction of Length and Rate Adaptive MET QC-LDPC Codes by Cyclic Group Decomposition," 2019 IEEE East-West Design & Test Symposium (EWDTS), Batumi, Georgia, 2019, pp. 1-5. https://ieeexplore.ieee.org/document/8884427

   
3. Usatyuk V.S., Yegorov S.I. Construction of quasi-cyclic non-binary LDPC codes, based on joint optimization of distance properties and connection spectra of codes. Telecommunications and Radio Engineering V. 8, 2016, pp. 32-40. (Rus)

   
4. Usatjuk V.S. Computing the minimum distance of nonbinary ldpc codes using block korkin-zolotarev method. Proceedings of the Southwest State University Series: Control, Computer Engineering, Information Science. Medical Instruments Engineering. - 2015. - № 3 (16). - pp. 76-85. (Rus)


5. Usatyuk V.S.. Implementation of the parallel shortest vector enumeration in the block Korkin–Zolotarev method Prikladnaya Diskretnaya Matematika. Supplement, 2013, pp. 130-131. (Rus)


6. Usatyuk V.S. The implementation of the parallel orthogonalization algorithms in the shortest integer lattices basis problem. Prikladnaya Diskretnaya Matematika. Supplement, 2012, pp. 120-122. (Rus)


7. Usatyuk V.S., Kuzmin O.V. Parallel algorithms for integer lattices basis reduction, V. 1,  2015, pp. 55-62. (Rus)



