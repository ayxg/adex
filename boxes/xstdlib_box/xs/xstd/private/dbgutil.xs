// Debugging Utilities
void debug_print(string value = "",string lbl = ""){
  string msg = "<GREEN>[DBG]";
  if(lbl == "") xsChatData("<GREEN>[DBG]" +  "["+value+"]");
  else xsChatData("<GREEN>[DBG]" + "["+value+"]" + "["+lbl+"]");
}