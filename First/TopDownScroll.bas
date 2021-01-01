10 for i=40960to49151:poke i,peek(i):next
20 for i=57344to65535:poke i,peek(i):next
30 poke 59639,3:poke1,53:sc=0
40 POKE 781,24: POKE 782,5: POKE 783,PEEK(783) AND 254: SYS65520:poke 1024+5*40+15,32:printtab(10)"#{right*10}#"
50 poke 1024+5*40+15,91
60 POKE 781,2: POKE 782,0: POKE 783,PEEK(783) AND 254: SYS65520: print"Score:";sc
70 sc=sc+1:goto 40


!-40 poke 1024+4*40+10,91
!-50 POKE 781,3: POKE 782,0: POKE 783,PEEK(783) AND 254: SYS65520: for i=0to10:next:sys59749
!-60 goto 40

