/* -------------------------------------------------------------------------
 *
 * nodeBitmapHeapscan.h
 *
 *
 *
 * Portions Copyright (c) 1996-2012, PostgreSQL Global Development Group
 * Portions Copyright (c) 1994, Regents of the University of California
 *
 * src/include/executor/nodeBitmapHeapscan.h
 *
 * -------------------------------------------------------------------------
 */
#ifndef NODEBITMAPHEAPSCAN_H
#define NODEBITMAPHEAPSCAN_H

#include "nodes/execnodes.h"
#include "access/parallel.h"

extern BitmapHeapScanState* ExecInitBitmapHeapScan(BitmapHeapScan* node, EState* estate, int eflags);
extern TupleTableSlot* ExecBitmapHeapScan(BitmapHeapScanState* node);
extern void ExecEndBitmapHeapScan(BitmapHeapScanState* node);
extern void ExecReScanBitmapHeapScan(BitmapHeapScanState* node);
extern void ExecBitmapHeapEstimate(BitmapHeapScanState *node, ParallelContext *pcxt);
extern void ExecBitmapHeapInitializeDSM(BitmapHeapScanState *node, ParallelContext *pcxt, int nodeid);
extern void ExecBitmapHeapReInitializeDSM(BitmapHeapScanState *node, ParallelContext *pcxt);
extern void ExecBitmapHeapInitializeWorker(BitmapHeapScanState *node, void *context);

#endif /* NODEBITMAPHEAPSCAN_H */
