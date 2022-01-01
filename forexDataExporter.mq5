//+------------------------------------------------------------------+
//|                                               myDataExporter.mq5 |
//|                                  Copyright 2021, MetaQuotes Ltd. |
//|                                       https://www.m-abbaspour.ir |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Ltd."
#property link      "https://www.m-abbaspour.ir"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int currentCandleNo=0;
int OnInit()
 { 
   currentCandleNo=iBars(Symbol(),PERIOD_CURRENT); 
   int f=FileOpen("data.csv",FILE_READ|FILE_WRITE|FILE_TXT);
      FileSeek(f,0,SEEK_END);
      FileWrite(f,"DateTime,Open,High,Low,Close,Ma9,MA26,MA52,MA104,RSI"); 
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
      
      double ma9=iMA(Symbol(), PERIOD_CURRENT,9,1,  MODE_SMA, PRICE_CLOSE);
      double movingAverageValues9[]; 
      ArraySetAsSeries (movingAverageValues9, true);
      CopyBuffer(ma9,0, 0, 100, movingAverageValues9);
      
      double ma26=iMA(Symbol(), PERIOD_CURRENT,26,1,  MODE_SMA, PRICE_CLOSE);
      double movingAverageValues26[]; 
      ArraySetAsSeries (movingAverageValues26, true);
      CopyBuffer(ma26,0, 0, 100, movingAverageValues26);
      
      double ma52=iMA(Symbol(), PERIOD_CURRENT,52,1,  MODE_SMA, PRICE_CLOSE);
      double movingAverageValues52[]; 
      ArraySetAsSeries (movingAverageValues52, true);
      CopyBuffer(ma52,0, 0, 100, movingAverageValues52);
      
      double ma104=iMA(Symbol(), PERIOD_CURRENT,104,1,  MODE_SMA, PRICE_CLOSE);
      double movingAverageValues104[]; 
      ArraySetAsSeries (movingAverageValues104, true);
      CopyBuffer(ma104,0, 0, 100, movingAverageValues104);
      
      
      double rsi=iRSI (Symbol(),PERIOD_CURRENT,14,PRICE_CLOSE);
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
                                 +DoubleToString(rsiArray[0])); 
       FileFlush(h);    
       FileClose(h);
       currentCandleNo=number;
    }
  Comment("Number Of Candle:"+string(number));   
  }
//+------------------------------------------------------------------+
