#ifndef DEBUGGER_H
#define DEBUGGER_H


#define DBGER_OUT(__args...)\
{ \
    atomic \
    {\
            sprintf(signal DebuggerHandler.getDebugBuf(), __args); \
            signal DebuggerHandler.debugOutput(signal DebuggerHandler.getDebugBuf()); \
    } \
}

#endif /*DEBUGGER_H*/

