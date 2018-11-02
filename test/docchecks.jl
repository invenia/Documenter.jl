module DocCheckTests

using Test

using Markdown
using Documenter.DocChecks: linkcheck
using Documenter.Documents

@testset "DocChecks" begin
    @testset "linkcheck" begin
        src = md"""
            [HTTP (HTTP/1.1) success](http://www.google.com)
            [HTTPS (HTTP/2) success](https://www.google.com)
            [FTP success](ftp://ftp.iana.org/tz/data/etcetera)
            [FTP (no proto) success](ftp.iana.org/tz/data/etcetera)
            [Redirect success](google.com)
            """

        Documents.walk(Dict{Symbol, Any}(), src) do block
            doc = Documents.Document(; linkcheck=true)
            result = linkcheck(block, doc)
            @test doc.internal.errors == Set{Symbol}()
            result
        end
    end
end

end
