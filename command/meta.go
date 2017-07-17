package command

import (
	"bufio"
	"flag"
	"io"

	"github.com/mitchellh/cli"
)

// FlagSetFlags is an enum to define what flags are present in the
// default FlagSet returned by Meta.FlagSet.
type FlagSetFlags uint

const (
	// FlagSetNone is set when no flags are present.
	FlagSetNone FlagSetFlags = 0
	// FlagSetClient is our enum.
	FlagSetClient FlagSetFlags = 1 << iota
	// FlagSetDefault is our default flag set.
	FlagSetDefault = FlagSetClient
)

// Meta contains the meta-options and functionality that
// Replicator commands can inherit.
type Meta struct {
	UI cli.Ui
}

// FlagSet returns a FlagSet with the common flags that every
// command implements. The exact behavior of FlagSet can be configured
// using the flags as the second parameter, for example to disable
// server settings on the commands that don't talk to a server.
func (m *Meta) FlagSet(n string, fs FlagSetFlags) *flag.FlagSet {
	f := flag.NewFlagSet(n, flag.ContinueOnError)

	// Create an io.Writer that writes to our UI properly for errors.
	// This is kind of a hack, but it does the job. Basically: create
	// a pipe, use a scanner to break it into lines, and output each line
	// to the UI. Do this forever.
	errR, errW := io.Pipe()
	errScanner := bufio.NewScanner(errR)
	go func() {
		for errScanner.Scan() {
			m.UI.Error(errScanner.Text())
		}
	}()
	f.SetOutput(errW)

	return f
}
