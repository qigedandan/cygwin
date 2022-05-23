interface StateLockMan {
    command bool isLocked();
    command void reset();

    event void lockFired();
    event void unlockFired();
}

