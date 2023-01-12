// ADDI ra,ra,0x8F1
// ORI x12,ra,0x800
// SB ra,0xF23(x12)
// SW x12,0xF23(ra)
// LB sp,0xF23(x12)
// LW x13,0xF23(ra)

ADDI ra,zero,0x001
ADDI sp,zero,0x002
ADDI gp,zero,0x004
ADDI tp,zero,0x00F
ADDI t0,zero,0x01F
ADDI s1,zero,0x001
SW ra,0x001(ra)
SW sp,0x002(ra)
SW gp,0x003(ra)
SW ra,0x004(ra)
SW sp,0x005(ra)
SW gp,0x006(ra)
SW ra,0x007(ra)
SW sp,0x008(ra)
SW gp,0x009(ra)
SW ra,0x00A(ra)
SW sp,0x00B(ra)
SW gp,0x00C(ra)
LW t1,0x001(ra)
LW t2,0x002(ra)

//RESULT
SUB s0, t2, t1
SUB sp, sp, sp
OR tp, sp, sp
AND t0, sp, sp
OR sp, sp, sp

//RESULT WRITE TO DISPLAY
SW s0, 0xFF0(ra)


SW s1, 0xFF1(ra)





