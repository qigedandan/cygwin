

includes AM;
interface RouteSelect {

  /**
   * Whether there is currently a valid route.
   *
   * @return Whether there is a valid route.
   */
  command bool isActive();

  /**
   * Select a route and fill in all of the necessary routing
   * information to a packet.
   *
   * @param msg Message to select route for and fill in routing information.
   *
   * @return Whether a route was selected succesfully. On FAIL the
   * packet should not be sent.
   *
   */
  
  command error_t selectRoute(message_t * msg, uint8_t id, uint8_t resend, uint8_t monitor);
  command error_t selectDescendantRoute(message_t * msg, uint8_t id, uint8_t resend, uint8_t monitor);


  command error_t forwardFailed();


  /**
   * Given a TOS_MstPtr, initialize its routing fields to a known
   * state, specifying that the message is originating from this node.
   * This known state can then be used by selectRoute() to fill in
   * the necessary data.
   *
   * @param msg Message to select route for and fill in init data.
   *
   * @return Should always return SUCCESS.
   *
   */

  command error_t initializeFields(message_t * msg, uint8_t id);
  
  
  /**
   * Given a TinyOS message buffer, provide a pointer to the data
   * buffer within it that an application can use as well as its
   * length. Unlike the getBuffer of the Send interface, this can
   * be called freely and does not modify the buffer.
   *
   * @param msg The message to get the data region of.
   *
   * @param length Pointer to a field to store the length of the data region.
   *
   * @return A pointer to the data region.
   */
  
  command uint8_t* getBuffer(message_t * msg, uint16_t* len);
}
