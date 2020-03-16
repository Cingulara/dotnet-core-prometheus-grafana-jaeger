restore:  
	dotnet restore locationsapi
	dotnet restore peopleapi

build:  
	dotnet build locationsapi
	dotnet build peopleapi

clean:
	@rm -f -r locationsapi/obj
	@rm -f -r locationsapi/bin
	@rm -f -r peopleapi/obj
	@rm -f -r peopleapi/bin

DEFAULT: build
