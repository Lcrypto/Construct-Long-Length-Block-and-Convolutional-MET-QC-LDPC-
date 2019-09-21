from_block_proto='MET_LDPC_Block_code_parity.txt'; % parity-check matrix of MET QC-LDPC codes
numberOfCopies=3; % coupling number
to_LDPCC_proto='Spatial_couple_proto.txt'; % save protograph of convolutional codes
h2tbldpcqc(from_block_proto,numberOfCopies,to_LDPCC_proto)
