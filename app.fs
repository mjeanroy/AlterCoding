module app

open System
open System.Linq
open Suave
open Suave.Web
open Suave.Http
open Suave.Successful
open Suave.Redirection
open Suave.Files
open Suave.Filters
open Suave.Operators
open Suave.RequestErrors

open FSharp.Data.TypeProviders
open FSharp.Linq

let app : WebPart =
    choose 
        [ 
            Filters.GET >=> choose 
                [ Filters.path "/" >=> Files.browseFileHome "index.html"
                  pathScan "/%s" (fun path -> Files.browseFileHome (sprintf "%s/index.html" path))
                  Files.browseHome ] 
            RequestErrors.NOT_FOUND "Page not found." 
        ]