
module RandomMlcgP {
  provides interface Init;
  provides interface ParameterInit<uint16_t> as SeedInit;
  provides interface Random as Random;
}
implementation
{
    uint32_t seed ;

  /* Initialize the seed from the ID of the node */
  command error_t Init.init() {
    atomic  seed = (uint32_t)(TOS_NODE_ID + 1);
    
    return SUCCESS;
  }

  /* Initialize with 16-bit seed */ 
  command error_t SeedInit.init(uint16_t s) {
    atomic  seed = (uint32_t)(s + 1);
    
    return SUCCESS;
  }

  /* Return the next 32 bit random number */
  async command uint32_t Random.rand32() {
    uint32_t mlcg,hi,lo;
    atomic
      {
	lo = 16807 * (seed & 0xFFFF);
	hi = 16807 * (mlcg >> 16);

	lo += (hi & 0x7FFF) << 16;
	lo += hi >> 15;

	if (lo > 0x7FFFFFFF) lo -= 0x7FFFFFFF;
	mlcg = (uint32_t) lo;
      }
    return mlcg; 
  }

  /* Return low 16 bits of next 32 bit random number */
  async command uint16_t Random.rand16() {
    return (uint16_t)call Random.rand32();
  }

#if 0
 /* Return high 16 bits of 32 bit number */
 inline uint16_t getHigh16(uint32_t num) {
    return num >> 16;
 }
#endif
}
