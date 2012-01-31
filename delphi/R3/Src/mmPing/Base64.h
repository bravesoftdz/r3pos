#pragma once

namespace Base64
{
	int Base64_Encode(const unsigned char*ps,unsigned char*&pd);
	void Base64_Decode(const char *ps,char *&pdp);

	int GetEncodeNewLen(const char * src);
	int GetDecodeNewLen(const char* src);
}
