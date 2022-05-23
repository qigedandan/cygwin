#include "CC2430_CSP.h"

module HplCC2420PinsP
{
  provides
  {
    interface GeneralIO as CCA;
    interface GeneralIO as CSN;
    interface GeneralIO as FIFO;
    interface GeneralIO as FIFOP;
    interface GeneralIO as RSTN;
    interface GeneralIO as SFD;
    interface GeneralIO as VREN;
  }

  uses interface HplCC2420Radio;

  uses interface WatchDog;
}
implementation
{
  uint16_t m_bug_cca = 0;
  
  /* CCA */
  async command void CCA.set()
  {
    _CC2430_RFSTATUS |= (1 << CC2430_RFSTATUS_CCA);
  }
  async command void CCA.clr()
  {
    _CC2430_RFSTATUS &= ~(1 << CC2430_RFSTATUS_CCA);
  }
  async command void CCA.toggle()
  {
    if (call CCA.get())
    {
      call CCA.clr();
    }
    else
    {
      call CCA.set();
    }
  }
  async command bool CCA.get()
  {
    bool cca;
    ADBG(1, "_CC2430_RFSTATUS=0x%x", (int)_CC2430_RFSTATUS);

    cca = (_CC2430_RFSTATUS & (1 << CC2430_RFSTATUS_CCA));

    if (!cca)
    {
         m_bug_cca++;
         if (m_bug_cca >= 2000)
         {
             m_bug_cca = 0;
             ADBG(100, "&*%$&^@*$(  BUG CCA!!!!\n");

             /* Known issue 2009-12-01, XLQ */
             call WatchDog.resetCpu();
         }
    }else{
    	m_bug_cca = 0;
    }
    
    
    return cca;
  }
  async command void CCA.makeInput()
  {
  }
  async command bool CCA.isInput()
  {
    return TRUE;
  }
  async command void CCA.makeOutput()
  {
  }
  async command bool CCA.isOutput()
  {
    return TRUE;
  }
  
  /* FIFO */
  async command void FIFO.set()
  {
    _CC2430_RFSTATUS |= (1 << CC2430_RFSTATUS_FIFO);
  }
  async command void FIFO.clr()
  {
    _CC2430_RFSTATUS &= ~(1 << CC2430_RFSTATUS_FIFO);
  }
  async command void FIFO.toggle()
  {
    if (call FIFO.get())
    {
      call FIFO.clr();
    }
    else
    {
      call FIFO.set();
    }
  }
  async command bool FIFO.get()
  {
    return (_CC2430_RFSTATUS & (1 << CC2430_RFSTATUS_FIFO));
  }
  async command void FIFO.makeInput()
  {
  }
  async command bool FIFO.isInput()
  {
    return TRUE;
  }
  async command void FIFO.makeOutput()
  {
  }
  async command bool FIFO.isOutput()
  {
    return TRUE;
  }
  
  /* FIFOP */
  async command void FIFOP.set()
  {
    _CC2430_RFSTATUS |= (1 << CC2430_RFSTATUS_FIFOP);
  }
  async command void FIFOP.clr()
  {
    _CC2430_RFSTATUS &= ~(1 << CC2430_RFSTATUS_FIFOP);
  }
  async command void FIFOP.toggle()
  {
    if (call FIFOP.get())
    {
      call FIFOP.clr();
    }
    else
    {
      call FIFOP.set();
    }
  }
  async command bool FIFOP.get()
  {
    return (_CC2430_RFSTATUS & (1 << CC2430_RFSTATUS_FIFOP));
  }
  async command void FIFOP.makeInput()
  {
  }
  async command bool FIFOP.isInput()
  {
    return TRUE;
  }
  async command void FIFOP.makeOutput()
  {
  }
  async command bool FIFOP.isOutput()
  {
    return TRUE;
  }
  
  
  /* SFD */
  async command void SFD.set()
  {
    _CC2430_RFSTATUS |= (1 << CC2430_RFSTATUS_SFD);
  }
  async command void SFD.clr()
  {
    _CC2430_RFSTATUS &= ~(1 << CC2430_RFSTATUS_SFD);
  }
  async command void SFD.toggle()
  {
    if (call SFD.get())
    {
      call SFD.clr();
    }
    else
    {
      call SFD.set();
    }
  }
  async command bool SFD.get()
  {
    return (_CC2430_RFSTATUS & (1 << CC2430_RFSTATUS_SFD));
  }
  async command void SFD.makeInput()
  {
  }
  async command bool SFD.isInput()
  {
    return TRUE;
  }
  async command void SFD.makeOutput()
  {
  }
  async command bool SFD.isOutput()
  {
    return TRUE;
  }
  
  
  /* VREN   ??????????????????? */
  async command void VREN.set()
  {
  }
  async command void VREN.clr()
  {
  }
  async command void VREN.toggle()
  {
  }
  async command bool VREN.get()
  {
  }
  async command void VREN.makeInput()
  {
  }
  async command bool VREN.isInput()
  {
    return TRUE;
  }
  async command void VREN.makeOutput()
  {
  }
  async command bool VREN.isOutput()
  {
    return TRUE;
  }
  
  /* CSN   ??????????????????? */
  async command void CSN.set()
  {
  }
  async command void CSN.clr()
  {
  }
  async command void CSN.toggle()
  {
  }
  async command bool CSN.get()
  {
  }
  async command void CSN.makeInput()
  {
  }
  async command bool CSN.isInput()
  {
    return TRUE;
  }
  async command void CSN.makeOutput()
  {
  }
  async command bool CSN.isOutput()
  {
    return TRUE;
  }
  
  
  /* RSTN */
  async command void RSTN.set()
  {
  }
  async command void RSTN.clr()
  {
  }
  async command void RSTN.toggle()
  {
  }
  async command bool RSTN.get()
  {
  }
  async command void RSTN.makeInput()
  {
  }
  async command bool RSTN.isInput()
  {
    return TRUE;
  }
  async command void RSTN.makeOutput()
  {
  }
  async command bool RSTN.isOutput()
  {
    return TRUE;
  }
}


