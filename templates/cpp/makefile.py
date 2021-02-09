import sys

print("CC := g++")
print("CPPFLAGS := -Wall -ggdb")
print
print

print("find_source = $(wildcard $(dir)/*.cpp)")
print("dirs := . add directories her")
print("sources := $(foreach dir,$(dirs),$(find_source))")
print

print("all: $(patsubst %.cpp, %.o, $(sources))")
print("    $(CC) $(CPPFLAGS) $^ -o test")
print

print("clear:")
print("    rm -f $(patsubst %.cpp, %.d, $(sources))")
print("    rm -f $(patsubst %.cpp, %.o, $(sources))")
print

print("%.d: %.cpp")
print("    set -e; $(CC) -MM $(CPPFLAGS) $< | sed 's/\($(notdir $*)\)\.o[ :]*/$(subst /,\/,$*).o $(subst /,\/,$@) : /g' > $@")
print

print("include $(sources:.cpp=.d)")
