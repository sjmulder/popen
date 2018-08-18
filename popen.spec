Name:		popen
Version:	%{_version}
Release:	1
Summary:	Open a process with a named pipe

License:	BSD
URL:		https://github.com/sjmulder/popen

%description
A command-line version of the popen(3) library function. Useful as a poor
man's substituate for the bash process substitution feature or as a more
convenient mkfifo(1) wrapper.

%prop
%setup

%build
make DESTDIR=%{buildroot} PREFIX=/usr MANPREFIX=/usr/share/man

%install
make DESTDIR=%{buildroot} PREFIX=/usr MANPREFIX=/usr/share/man install

%clean
rm -rf rpmbuild/

%files
/usr/bin/popen
/usr/share/man/man1/popen.1.gz
%doc README.md
%doc CHANGELOG.md
%license LICENSE.md
