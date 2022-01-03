//+------------------------------------------------------------------+
//|                                               myDataExporter.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                       https://www.m-abbaspour.ir |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.m-abbaspour.ir"
#property version   "1.00"

//+------------------------------------------------------------------+
//| Indicators Settings                                   |
//+------------------------------------------------------------------+

input group    "RSI Settings:";
input int ma_period = 14;
input ENUM_APPLIED_PRICE applied_price_rsi = PRICE_CLOSE;
//___________________________________________________________________
input group    "MA_9 Settings:";
input int ma_shift_9 = 1;
input ENUM_MA_METHOD ma_method_9 = MODE_SMA;
input ENUM_APPLIED_PRICE applied_price_9 = PRICE_CLOSE;
//___________________________________________________________________  
input group    "MA_26 Settings:";
input int ma_shift_26 = 1;
input ENUM_MA_METHOD ma_method_26 = MODE_SMA;
input ENUM_APPLIED_PRICE applied_price_26 = PRICE_CLOSE;
//___________________________________________________________________
input group    "MA_52 Settings:";
input int ma_shift_52 = 1;
input ENUM_MA_METHOD ma_method_52 = MODE_SMA;
input ENUM_APPLIED_PRICE applied_price_52 = PRICE_CLOSE;
//___________________________________________________________________
input group    "MA_104 Settings:";
input int ma_shift_104 = 1;
input ENUM_MA_METHOD ma_method_104 = MODE_SMA;
input ENUM_APPLIED_PRICE applied_price_104 = PRICE_CLOSE;
//___________________________________________________________________
input group    "MA_200 Settings:";
input int ma_shift_200 = 1;
input ENUM_MA_METHOD ma_method_200 = MODE_SMA;
input ENUM_APPLIED_PRICE applied_price_200 = PRICE_CLOSE;  

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int currentCandleNo=0;
int OnInit()
 { 
   currentCandleNo=iBars(Symbol(),PERIOD_CURRENT); 
   int f=FileOpen("data.csv",FILE_READ|FILE_WRITE|FILE_TXT);
      FileSeek(f,0,SEEK_END);
      FileWrite(f,"DateTime,Open,High,Low,Close,Ma9,MA26,MA52,MA104,MA200,RSI"); 
      FileFlush(f);    
      FileClose(f);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {  
  int number=iBars(Symbol(),PERIOD_CURRENT);
  if(number!=currentCandleNo)
    {
      datetime dt= iTime(Symbol(),PERIOD_CURRENT,1);
      double  open = iOpen(Symbol(),PERIOD_CURRENT,1);
      double close = iClose(Symbol(),PERIOD_CURRENT,1);
      double  high = iHigh(Symbol(),PERIOD_CURRENT,1);
      double   low = iLow(Symbol(),PERIOD_CURRENT,1);
      
      double ma9=iMA(Symbol(), PERIOD_CURRENT,9,ma_shift_9,ma_method_9,applied_price_9);
      double movingAverageValues9[]; 
      ArraySetAsSeries (movingAverageValues9, true);
      CopyBuffer(ma9,0, 0, 100, movingAverageValues9);
      
      double ma26=iMA(Symbol(), PERIOD_CURRENT,26,ma_shift_26,ma_method_26,applied_price_26);
      double movingAverageValues26[]; 
      ArraySetAsSeries (movingAverageValues26, true);
      CopyBuffer(ma26,0, 0, 100, movingAverageValues26);
      
      double ma52=iMA(Symbol(), PERIOD_CURRENT,52,ma_shift_52,ma_method_52,applied_price_52);
      double movingAverageValues52[]; 
      ArraySetAsSeries (movingAverageValues52, true);
      CopyBuffer(ma52,0, 0, 100, movingAverageValues52);
      
      double ma104=iMA(Symbol(), PERIOD_CURRENT,104,ma_shift_104,ma_method_104,applied_price_104);
      double movingAverageValues104[]; 
      ArraySetAsSeries (movingAverageValues104, true);
      CopyBuffer(ma104,0, 0, 100, movingAverageValues104);
      
      double ma200=iMA(Symbol(), PERIOD_CURRENT,200,ma_shift_200,ma_method_200,applied_price_200);
      double movingAverageValues200[]; 
      ArraySetAsSeries (movingAverageValues200, true);
      CopyBuffer(ma200,0, 0, 100, movingAverageValues200);
      
      double rsi=iRSI (Symbol(),PERIOD_CURRENT,ma_period,applied_price_rsi);
      double rsiArray[];
      ArraySetAsSeries(rsiArray, true);
      CopyBuffer(rsi,0,0,100,rsiArray);
      
      int h=FileOpen("data.csv",FILE_READ|FILE_WRITE|FILE_TXT);
      
      if(h==INVALID_HANDLE)
       {
         Alert("Error opening file");
         return;
       }
       FileSeek(h,0,SEEK_END);
       FileWrite(h,string(dt)+","+DoubleToString(open)+","
                                 +DoubleToString(high)+","
                                 +DoubleToString(low)+","
                                 +DoubleToString(close)+","
                                 +DoubleToString(movingAverageValues9[0])+","
                                 +DoubleToString(movingAverageValues26[0])+","
                                 +DoubleToString(movingAverageValues52[0])+","
                                 +DoubleToString(movingAverageValues104[0])+","
                                 +DoubleToString(movingAverageValues200[0])+","
                                 +DoubleToString(rsiArray[0])); 
       FileFlush(h);    
       FileClose(h);
       currentCandleNo=number;
    }
  Comment("Number Of Candle:"+string(number));   
  }
//+------------------------------------------------------------------+
