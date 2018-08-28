{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE TypeFamilies        #-}
{-# LANGUAGE TypeOperators       #-}
{-# LANGUAGE FlexibleContexts    #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE AllowAmbiguousTypes #-}

module Types where

import Java

---
data PipelineOptions = PipelineOptions @org.apache.beam.sdk.options.PipelineOptions
    deriving Class
----
data PipelineOptionsFactory = PipelineOptionsFactory @org.apache.beam.sdk.options.PipelineOptionsFactory
    deriving Class

foreign import java unsafe "@static org.apache.beam.sdk.options.PipelineOptionsFactory.create"
      createBeam :: Java a PipelineOptions

----
data Pipeline = Pipeline @org.apache.beam.sdk.Pipeline
    deriving Class

foreign import java unsafe "@static org.apache.beam.sdk.Pipeline.create"
      createPipeline :: PipelineOptions -> Java a Pipeline

foreign import java unsafe "apply" applyPipeline :: (a <: PBegin, OutputT <: POutput)
        => PTransform a OutputT -> Java Pipeline OutputT
----
data PTransform InputT OutputT = PTransform (@org.apache.beam.sdk.transforms.PTransform InputT OutputT)
    deriving Class

----
data PBegin = PBegin @org.apache.beam.sdk.values.PBegin
    deriving Class

----
data POutput = POutput @org.apache.beam.sdk.values.POutput
    deriving Class

----
data TextIO = TextIO @org.apache.beam.sdk.io.TextIO
    deriving Class

foreign import java unsafe "@static org.apache.beam.sdk.io.TextIO.read" readBeam
      :: Java a TextIORead
----
data (PCollection t) = PCollection (@org.apache.beam.sdk.values.PCollection t)
    deriving Class

----
data TextIO$Read = TextIORead @org.apache.beam.sdk.io.TextIO$Read
    deriving Class

type instance Inherits TextIORead = '[PTransform PBegin (PCollection String)]

foreign import java unsafe "from" fromBeam
      :: String -> Java TextIORead TextIORead
