FROM swift:5.3-focal as build

WORKDIR /package

COPY . ./

CMD ["swift", "test", "--enable-test-discovery"]
