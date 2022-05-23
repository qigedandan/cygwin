configuration AtomMeshC
{
    provides 
    {
        interface Init;
        interface StdControl;
        interface Send[uint8_t id];
        interface Receive[uint8_t id];
        interface Intercept as Intercept[uint8_t id];
        interface Intercept as Snoop[uint8_t id];
    }
    uses
    {
        interface AMSend[uint8_t id];
        interface AMPacket;
        interface Packet;

        interface Receive as ReceiveMsg[uint8_t id];
        interface Receive as ReceiveDownstreamMsg[uint8_t id];
        
        interface SplitControl as AMControl;
        interface Timer<TMilli> as RouterTimer;
        interface CC2420Packet;

        interface HALCC2420;
        interface StdControl as HALCC2420Control;
    }
}
implementation
{
    components AtomMeshM;
    Init = AtomMeshM;
    StdControl = AtomMeshM.StdControl;
    HALCC2420 = AtomMeshM;
    HALCC2420Control = AtomMeshM.HALCC2420Control;
    
    components EWMAMultiHopRouter as Router;
    AtomMeshM.SubInit -> Router.Init;
    AtomMeshM.RouterControl -> Router.StdControl;
    
    Send = Router.Send;
    Receive = Router.Receive;
    Intercept = Router.Intercept;
    Snoop = Router.Snoop;

    AMSend = Router.AMSend;
    ReceiveMsg = Router.ReceiveMsg;
    ReceiveDownstreamMsg = Router.ReceiveDownstreamMsg;
    AMPacket = Router.AMPacket;
    Packet = Router.Packet;

    AMControl = Router.AMControl;
    RouterTimer= Router.RouterTimer;
    CC2420Packet = Router.CC2420Packet;
    
}
