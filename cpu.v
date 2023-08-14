module cpu(
    input wire clk,
    input wire reset
);

    wire Overflow;
    wire Neg;
    wire Zero;
    wire Eq;
    wire Gt;
    wire LT;


    wire PC_write;
    wire MEM_write;
    wire IR_write;
    wire Regwrite;
    wire A_write;
    wire B_write;
    wire ALUOutCtrl;
    wire div_Control;
    wire mult_Control;

    wire [2:0] Alu_control;

    wire aluSourceA_control;
    wire [1:0] aluSourceB_control;
    wire HIWrite;
    wire LOWrite;

    wire [31:0] PCSrc_output;
    wire [31:0] ALU_Out;
    wire [31:0] PCOut;
    wire [31:0] MEM_out;

    wire [31:26] OPCODE;
    wire [25:21] RS;
    wire [20:16] RT;
    wire [15:0] OFFSET;

    wire [31:0] ReadDataA;
    wire [31:0] ReadDataB;
    wire [31:0] A_output;
    wire [31:0] B_output;
    wire [31:0] sign_extend_1_out;
    wire [31:0] scrA_output;
    wire [31:0] srcB_output;

    wire ShiftAmt;
    wire [4:0] ShiftAmt_output;

    wire [1:0] mux_toRegs_control;   // 3 bits
    wire [4:0] regDest_output;

    wire [3:0] srcData_control;
    wire [31:0] mux_to_reg_out;

    wire ShiftSrc;
    wire [31:0] ShiftSrc_output;

    wire [31:0] sign_extend1_32_output;

    wire [1:0] mux_IorD_control;

    wire [2:0] ShiftControl;
    wire [31:0] shiftReg_output;

    wire [2:0] pcSource_control;
    wire [31:0] conc_SL26_PC_output;
    wire [31:0] ALU_Result;

    wire [31:0] MultHi_output;
    wire [31:0] MultLo_output;

    wire [31:0] DivHi_output;
    wire [31:0] DivLo_output;
    wire [31:0] HI_output;
    wire [31:0] LO_output;

    wire mux_Hi_control;
    wire [31:0] mux_Hi_Out;
    wire mux_Lo_control;
    wire [31:0] mux_Lo_Out;

    wire [31:0] SL_16to32_output;

    wire [31:0] iord_output;

    wire [31:0] MemDataReg_out;
    wire [31:0] controlSS_output;

    wire [1:0] LScontrol;
    wire [31:0] LScontrol_output;

    wire MDR_Write;

    wire [1:0] controlSS;

    wire EPCCtrl;
    wire [31:0] EPC_output;

    wire [31:0] sign_extend8_32_output;
    wire [31:0] shift_left_2_output;



    SS SS_(
        controlSS,
        B_output,
        MemDataReg_out,

        controlSS_output
    );



    shift_amount shift_amount_(
        ShiftAmt,
        B_output,
        OFFSET[10:6],
        ShiftAmt_output
    );

    RegDesloc Shift_reg_(
        clk,
        reset,
        ShiftControl,
        ShiftAmt_output,
        ShiftSrc_output,
        shiftReg_output
    );

    shift_src shift_src_(
        ShiftSrc,
        A_output,
        B_output,
        ShiftSrc_output
    );

    LoadSize LS_(
        LScontrol,
        MemDataReg_out,

        LScontrol_output
    );

    Memoria MEM_(
        iord_output,
        clk,
        MEM_write,
        controlSS_output,
        MEM_out
    );

    sign_extend8_32 sign_extend8_32_(
        MEM_out,
        sign_extend8_32_output
    );

    Instr_Reg IR_(
        clk,
        reset,
        IR_write,
        MEM_out,
        OPCODE,
        RS,
        RT,
        OFFSET
    );

    reg_destination mux_Regs_(
        mux_toRegs_control,
        RT,
        OFFSET[15:11],
        regDest_output
    );


    Registrador PC_(
        clk,
        reset,
        PC_write,
        PCSrc_output,
        PCOut
    );

    Banco_reg REG_BASE_(
        clk,
        reset,
        Regwrite,
        RS,
        RT,
        regDest_output,
        mux_to_reg_out,
        ReadDataA,
        ReadDataB
    );

    Registrador HI_(
        clk,
        reset,
        HIWrite,
        mux_Hi_Out,
        HI_output
    );

    Registrador LO_(
        clk,
        reset,
        LOWrite,
        mux_Lo_Out,
        LO_output
    );

    Registrador A_(
        clk,
        reset,
        A_write,
        ReadDataA,
        A_output
    );

    Registrador B_(
        clk,
        reset,
        B_write,
        ReadDataB,
        B_output
    );

    Registrador ALUOut_(
        clk,
        reset,
        ALUOutCtrl,
        ALU_Result,
        ALU_Out
    );

    ula32 ULA_(
        scrA_output,
        srcB_output,
        Alu_control,

        ALU_Result,
        Overflow,
        Neg,
        Zero,
        Eq,
        Gt,
        LT
    );

    shift_left_2 shift_left_2_(
        sign_extend_1_out,
        shift_left_2_output
    );


    Registrador MDR(
        clk,
        reset,
        MDR_Write,
        MEM_out,

        MemDataReg_out
    );

    Registrador EPC(
        clk,
        reset,
        EPCCtrl,
        ALU_Result,
        EPC_output
    );

    sign_extend_1 Sign_extend_1(
        OFFSET,
        sign_extend_1_out
    );

    sign_extend1_32 sign_extend1_32_(
        LT,
        sign_extend1_32_output
    );

    mux_SrcData mux_SrcData_(
        srcData_control,
        ALU_Out,
        sign_extend1_32_output,
        shiftReg_output,
        HI_output,
        LO_output,
        SL_16to32_output,
        LScontrol_output,

        mux_to_reg_out
    );

    mux_aluSrcA mux_aluSrcA_(
        aluSourceA_control,
        PCOut,
        A_output,
        scrA_output
    );

    mux_aluSrcB mux_aluSrcB_(
        aluSourceB_control,
        B_output,
        sign_extend_1_out,
        shift_left_2_output,
        srcB_output
    );

    mux_IorD mux_IorD_(
        mux_IorD_control,
        PCOut,
        ALU_Result,
        ALU_Out,

        iord_output
    );

    concat concat_(
        RS,
        RT,
        OFFSET,
        PCOut,

        conc_SL26_PC_output
    );

    sign_Extend16 sign_Extend16_(
        OFFSET,

        SL_16to32_output
    );

    mux_pcSource mux_pcSource_(
        pcSource_control,

        ALU_Result,
        conc_SL26_PC_output,
        ALU_Out,
        EPC_output,
        sign_extend8_32_output,

        PCSrc_output
    );

    mult mult_(
        clk,
        reset,
        mult_Control,
        A_output,
        B_output,
        MultHi_output,
        MultLo_output
    );

    div div_(
        clk,
        reset,
        div_Control,
        A_output,
        B_output,
        Zero,
        DivHi_output,
        DivLo_output
    );


    mux_Hi mux_Hi_(
        MultHi_output,
        DivHi_output,
        mux_Hi_control,
        mux_Hi_Out
    );

    mux_Low mux_Low_(
        MultLo_output,
        DivLo_output,
        mux_Lo_control,
        mux_Lo_Out
    );

    unit_control CTRL_(
        clk,
        reset,
        Eq,
        Gt,
        Neg,
        Zero,
        LT,
        Overflow,
        PC_write,
        A_write,
        B_write,
        ALUOutCtrl,
        ShiftAmt,
        ShiftSrc,
        ShiftControl,
        Alu_control,
        aluSourceA_control,
        aluSourceB_control,
        HIWrite,
        LOWrite,
        mux_toRegs_control,
        srcData_control,
        pcSource_control,
        MEM_write,
        IR_write,
        Regwrite,
        mux_IorD_control,
        controlSS,
        MDR_Write,
        EPCCtrl,
        LScontrol,
        div_Control,
        mult_Control,
        mux_Hi_control,
        mux_Lo_control,
        reset,
        OPCODE,
        OFFSET[5:0]
    );

endmodule