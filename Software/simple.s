main:                                   # @main
        addi    sp, sp, -96
        sw      ra, 92(sp)                      # 4-byte Folded Spill
        sw      s0, 88(sp)                      # 4-byte Folded Spill
        addi    s0, sp, 96
        li      a0, 0
        sw      a0, -12(s0)
        li      a1, 10
        sw      a1, -16(s0)
        sw      a1, -20(s0)
        sw      a1, -24(s0)
        sw      a1, -28(s0)
        li      a1, 1
        sw      a1, -32(s0)
        sw      a1, -36(s0)
        sw      a1, -40(s0)
        sw      a1, -44(s0)
        li      a1, 2
        sw      a1, -48(s0)
        sw      a1, -52(s0)
        sw      a0, -76(s0)
        j       .LBB0_1
.LBB0_1:                                # =>This Loop Header: Depth=1
        lw      a0, -76(s0)
        lw      a1, -48(s0)
        bge     a0, a1, .LBB0_12
        j       .LBB0_2
.LBB0_2:                                #   in Loop: Header=BB0_1 Depth=1
        li      a0, 0
        sw      a0, -80(s0)
        j       .LBB0_3
.LBB0_3:                                #   Parent Loop BB0_1 Depth=1
        lw      a0, -80(s0)
        lw      a1, -52(s0)
        bge     a0, a1, .LBB0_10
        j       .LBB0_4
.LBB0_4:                                #   in Loop: Header=BB0_3 Depth=2
        li      a0, 0
        sw      a0, -72(s0)
        sw      a0, -84(s0)
        j       .LBB0_5
.LBB0_5:                                #   Parent Loop BB0_1 Depth=1
        lw      a1, -84(s0)
        li      a0, 1
        bltu    a0, a1, .LBB0_8
        j       .LBB0_6
.LBB0_6:                                #   in Loop: Header=BB0_5 Depth=3
        lw      a0, -76(s0)
        slli    a1, a0, 3
        addi    a0, s0, -28
        add     a0, a0, a1
        lw      a1, -84(s0)
        slli    a2, a1, 2
        add     a0, a0, a2
        lw      a0, 0(a0)
        slli    a2, a1, 3
        addi    a1, s0, -44
        add     a1, a1, a2
        lw      a2, -80(s0)
        slli    a2, a2, 2
        add     a1, a1, a2
        lw      a1, 0(a1)
        mul     a1, a0, a1
        lw      a0, -72(s0)
        add     a0, a0, a1
        sw      a0, -72(s0)
        j       .LBB0_7
.LBB0_7:                                #   in Loop: Header=BB0_5 Depth=3
        lw      a0, -84(s0)
        addi    a0, a0, 1
        sw      a0, -84(s0)
        j       .LBB0_5
.LBB0_8:                                #   in Loop: Header=BB0_3 Depth=2
        lw      a0, -72(s0)
        lw      a1, -76(s0)
        slli    a2, a1, 3
        addi    a1, s0, -68
        add     a1, a1, a2
        lw      a2, -80(s0)
        slli    a2, a2, 2
        add     a1, a1, a2
        sw      a0, 0(a1)
        j       .LBB0_9
.LBB0_9:                                #   in Loop: Header=BB0_3 Depth=2
        lw      a0, -80(s0)
        addi    a0, a0, 1
        sw      a0, -80(s0)
        j       .LBB0_3
.LBB0_10:                               #   in Loop: Header=BB0_1 Depth=1
        j       .LBB0_11
.LBB0_11:                               #   in Loop: Header=BB0_1 Depth=1
        lw      a0, -76(s0)
        addi    a0, a0, 1
        sw      a0, -76(s0)
        j       .LBB0_1
.LBB0_12:
        lw      a0, -12(s0)
        lw      a1, -68(s0)
        lw      ra, 92(sp)                      # 4-byte Folded Reload
        lw      s0, 88(sp)                      # 4-byte Folded Reload
        addi    sp, sp, 96
        ret