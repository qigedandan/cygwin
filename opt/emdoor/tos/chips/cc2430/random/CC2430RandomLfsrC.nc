
configuration CC2430RandomLfsrC
{
  provides interface Init;
  provides interface Random;
}
implementation
{
  components CC2430RandomLfsrP;

  Init = CC2430RandomLfsrP;
  Random = CC2430RandomLfsrP;
}

