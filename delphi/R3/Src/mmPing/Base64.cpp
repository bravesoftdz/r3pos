#include "StdAfx.h"

#ifndef __BASE64_CPP__
#define __BASE64_CPP__

namespace Base64
{
	//编码表
	unsigned char EncodeIndex[] = {
		'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',
			'Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f',
			'g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v',
			'w','x','y','z','0','1','2','3','4','5','6','7','8','9','+','/'};

		int GetEncodeNewLen(const char * src)
		{
			int len = strlen((char*)src);
			return len/3*4 +((len%3 == 0)?0:4) + 1;
		}		

		int GetDecodeNewLen(const char* src)
			{
				int len = strlen(src);
				return len/4*3+1;
			}

		int Base64_Encode(const unsigned char*ps,unsigned char*&pd)
		{
			int len = strlen((char*)ps);
			int i=0;
			int pos = 0;
			unsigned char c1,c2,c3;

			while(i<len)
			{
				c1 = ps[i++] & 0xFF;
				if(i == len)
				{
					pd[pos++] = EncodeIndex[c1 >> 2];
					pd[pos++] = EncodeIndex[(c1 & 0x03)<<4];
					pd[pos++] = '=';
					pd[pos++] = '=';
					break;
				}

				c2 = ps[i++];
				if(i == len)
				{
					pd[pos++] = EncodeIndex[c1 >> 2];
					pd[pos++] = EncodeIndex[((c1 & 0x03) << 4)|((c2 & 0xF0) >> 4)];
					pd[pos++] = EncodeIndex[(c2 & 0x0F) << 2];
					pd[pos++] = '=';
					break;
				}

				c3 = ps[i++];
				pd[pos++] = EncodeIndex[c1 >> 2];
				pd[pos++] = EncodeIndex[((c1 & 0x03) << 4)|((c2 & 0xF0) >> 4)];
				pd[pos++] = EncodeIndex[((c2 & 0x0F) << 2)|((c3 & 0xC0) >> 6)];
				pd[pos++] = EncodeIndex[c3 & 0x3F];
			}
			
			return true;
		}
		void Base64_Decode(const char *ps,char *&pdp)
		{
			char *pd = pdp;
			int len = strlen(ps);
			int step = len / 4 + (len%4==0?0:1);
			int m,n;
			m = n = 0;
			char ct[4];
			for(int i=0;i<step;i++)
			{
				for(int j=0;j<4;j++)
				{
					char c = ps[m++];
					if(c>=65 && c<=90)
					{
						ct[j] = c - 'A';
					}
					else if(c>=97 && c<=122)
					{
						ct[j] = c - 'a' + 26;
					}
					else if(c>=48 && c<=57)
					{
						ct[j] = c - '0' + 52;
					}
					else if(c== 43)
					{
						ct[j] = 62;
					}
					else if(c == 47)
					{
						ct[j] = 63;
					}
					else if(c == 61)
					{
						//这是个==,表示结束
						ct[j] = -1;
					}					
				}
				//

				pd[n++] = ct[0]<<2 | ct[1]>>4;
				if(ct[2] != -1 && ct[3] !=-1)
				{
					pd[n++] = ct[1]<<4|ct[2]>>2;
					pd[n++] = ct[2]<<6|ct[3];
				}
				else if(ct[2] != -1 && ct[3] == -1)
				{
					pd[n++] = ct[1]<<4|ct[2]>>2;
					return;					
				}
				else
				{
					
				}

			}
		}
		/*
		//使用代码
		char *ps="1234456677 abcdfadf 哈哈哈,我就是中文,你怎么的 abcdfadf";
	int len = Base64::GetEncodeNewLen(ps);
	char *pd = new char[len];
	::ZeroMemory(pd,len);
	Base64::Base64_Encode((unsigned char*)ps,(unsigned char *&)pd);
	printf("%s\n",ps);
	printf("%s\n",pd);

	len = Base64::GetDecodeNewLen(pd);
	char *pe = new char[len];
	::ZeroMemory(pe,len+1);
	Base64::Base64_Decode(pd,pe);
	printf("%s\n",pe);
		*/
}
#endif //__BASE64_CPP__