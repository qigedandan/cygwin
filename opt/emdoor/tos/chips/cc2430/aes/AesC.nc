
configuration AesC{
  provides interface Aes;
}

implementation {

	components AesP;
	
	Aes = AesP;
}

