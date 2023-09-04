function run() {
  const [command, ...args] = Bun.argv.slice(2).map((arg) => arg.split("="), []);
  console.log(command, args);

  return (([_, ...query]) => {
    const [__, ...chain] = query;

    return {
      to: {
        chain: chain
      }
    }
  })([...args]);
}

run()