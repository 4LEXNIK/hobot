/*
Copyright © 2023 NAME HERE <EMAIL ADDRESS>
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	//Teletoken bot
	TeleToken = os.Getenv("TELE_TOKEN")
)

// hobotCmd represents the hobot command
var hobotCmd = &cobra.Command{
	Use:   "hobot",
	Aliases: []string{"go"},
	Short: "A brief description of your command",
	Long: `A longer description that spans multiple lines and likely contains examples
and usage of using your command. For example:

Cobra is a CLI library for Go that empowers applications.
This application is a tool to generate the needed files
to quickly create a Cobra application.`,
	Run: func(cmd *cobra.Command, args []string) {
		
		fmt.Printf("hobot started %s", appVersion)

		hobot, err := telebot.NewBot(telebot.Settings{
			URL: "",
			Token: TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please check TELE_TOKEN env variable. %s", err)
			return
		}

		hobot.Handle(telebot.OnText, func(m telebot.Context) error {
			
			log.Print(m.Message().Payload, m.Text())
			payload := m.Message().Payload

			switch payload {
			case "hello":
				err = m.Send(fmt.Sprintf("Hello i'm hobot %s", appVersion))
			case "hi":
				err = m.Send(fmt.Sprintf("Hi, wat's up? I'm a hobot %s", appVersion))
			}

			return err

		})
		hobot.Start()
	},
}

func init() {
	rootCmd.AddCommand(hobotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// hobotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// hobotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}
