package ram_type_pkg is
    type t_req_type is (
                        REQ_NONE
                       ,REQ_CPU_FAST_RD
                       ,REQ_CPU_CHIP_RD
                       ,REQ_CPU_RD
                       ,REQ_CPU_RD_WAIT
                       ,REQ_CPU_WR
                       ,REQ_DMA_CHIP_RD
                       ,REQ_DMA_CHIP_RD_WAIT
                       ,REQ_DMA_CHIP_RD_BURST
                       ,REQ_DMA_WR
                    );                    
end package;
